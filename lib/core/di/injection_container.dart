import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipe_finder/core/platform/network_info.dart';
import 'package:recipe_finder/features/recipe_search/data/datasources/recipe_local_datasource.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';
import '../../features/favorites/data/datasources/favorite_local_data_source.dart';
import '../../features/favorites/data/repositories/favorite_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorite_repository.dart';
import '../../features/favorites/domain/usecases/add_favorite.dart';
import '../../features/favorites/domain/usecases/get_favorite.dart';
import '../../features/favorites/domain/usecases/is_favorite.dart';
import '../../features/favorites/domain/usecases/remove_favorite.dart';
import '../../features/favorites/presentation/bloc/favorite_bloc.dart';
import '../../features/meal_plan/data/datasources/meal_plan_local_data_source.dart';
import '../../features/meal_plan/data/repositories/meal_plan_repository_impl.dart';
import '../../features/meal_plan/domain/entities/meal_plan_item.dart';
import '../../features/meal_plan/domain/repositories/meal_plan_repository.dart';
import '../../features/meal_plan/domain/usecases/add_to_meal_plan.dart';
import '../../features/meal_plan/domain/usecases/get_meal_plan.dart';
import '../../features/meal_plan/domain/usecases/remove_meal_plan.dart';
import '../../features/meal_plan/presentation/bloc/meal_plan_bloc.dart';
import '../../features/recipe_detail/data/datasources/recipe_detail_remote_datasource.dart';
import '../../features/recipe_detail/data/repositories/recipe_detail_repository_impl.dart';
import '../../features/recipe_detail/domain/repositories/recipe_detail_repository.dart';
import '../../features/recipe_detail/domain/usecases/get_recipe_detail.dart';
import '../../features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import '../../features/recipe_search/data/datasources/recipe_remote_datasource.dart';
import '../../features/recipe_search/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe_search/domain/repositories/recipes_repository.dart';
import '../../features/recipe_search/domain/usecases/search_recipes.dart';
import '../../features/recipe_search/presentation/bloc/recipe_bloc.dart';
import '../constant/db_constant.dart';

final getIt = GetIt.instance;


Future<void> init() async {
  await _initRecipeSearch();
  _initRecipeDetail();
  await _initFavorites();
  await _initMealPlan();

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton(() => Connectivity());

  getIt.registerLazySingleton(() {
    final dio = Dio();
    final cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.refreshForceCache,
      maxStale: const Duration(minutes: 30),
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    return dio;
  });
}

Future<void> _initRecipeSearch() async {
  getIt.registerFactory(() => RecipeSearchBloc(searchRecipes: getIt()));
  getIt.registerLazySingleton(() => SearchRecipes(getIt()));
  getIt.registerLazySingleton<RecipeRepository>(
        () => RecipeRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<RecipeRemoteDataSource>(
        () => RecipeRemoteDataSourceImpl(dio: getIt()),
  );
  getIt.registerLazySingleton<RecipeLocalDataSource>(
        () => RecipeLocalDataSourceImpl(box: getIt(instanceName: searchCacheBoxName)),
  );
  if (!getIt.isRegistered<Box>(instanceName: searchCacheBoxName)) {
    final searchCacheBox = await Hive.openBox(searchCacheBoxName);
    getIt.registerLazySingleton<Box>(() => searchCacheBox, instanceName: searchCacheBoxName);
  }
}

void _initRecipeDetail() {
  getIt.registerFactory(() => RecipeDetailBloc(getRecipeDetail: getIt()));
  getIt.registerLazySingleton(() => GetRecipeDetail(getIt()));
  getIt.registerLazySingleton<RecipeDetailRepository>(
        () => RecipeDetailRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<RecipeDetailRemoteDataSource>(
        () => RecipeDetailRemoteDataSourceImpl(dio: getIt()),
  );
}

Future<void> _initFavorites() async {
  getIt.registerFactory(
        () => FavoriteBloc(
      getFavorites: getIt(),
      addFavorite: getIt(),
      removeFavorite: getIt(),
      isFavorite: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => GetFavorites(getIt()));
  getIt.registerLazySingleton(() => AddFavorite(getIt()));
  getIt.registerLazySingleton(() => RemoveFavorite(getIt()));
  getIt.registerLazySingleton(() => IsFavorite(getIt()));
  getIt.registerLazySingleton<FavoriteRepository>(
        () => FavoriteRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<FavoriteLocalDataSource>(
        () => FavoriteLocalDataSourceImpl(favoriteBox: getIt()),
  );

  if (!getIt.isRegistered<Box<Recipe>>()) {
    final favoriteBox = await Hive.openBox<Recipe>(favoriteBoxName);
    getIt.registerLazySingleton(() => favoriteBox);
  }
}

Future<void> _initMealPlan() async {
  getIt.registerFactory(
        () => MealPlanBloc(
      getMealPlan: getIt(),
      addToMealPlan: getIt(),
      removeFromMealPlan: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => GetMealPlan(getIt()));
  getIt.registerLazySingleton(() => AddToMealPlan(getIt()));
  getIt.registerLazySingleton(() => RemoveFromMealPlan(getIt()));
  getIt.registerLazySingleton<MealPlanRepository>(
        () => MealPlanRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<MealPlanLocalDataSource>(
        () => MealPlanLocalDataSourceImpl(mealPlanBox: getIt()),
  );
  if (!getIt.isRegistered<Box<MealPlanItem>>()) {
    final mealPlanBox = await Hive.openBox<MealPlanItem>(mealPlanBoxName);
    getIt.registerLazySingleton(() => mealPlanBox);
  }
}
