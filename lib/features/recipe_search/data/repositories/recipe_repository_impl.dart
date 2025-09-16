import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/core/platform/network_info.dart';
import 'package:recipe_finder/features/recipe_search/data/datasources/recipe_local_datasource.dart';
import 'package:recipe_finder/features/recipe_search/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipe_search/domain/repositories/recipes_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final RecipeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipes(String ingredients) async {
    final localResult = await localDataSource.getCachedSearchResults(ingredients);

    return localResult.fold(
          (failure) async {
        if (await networkInfo.isConnected) {
          final remoteResult = await remoteDataSource.searchRecipes(ingredients);
          return remoteResult.fold(
                (failure) => Left(failure),
                (recipes) {
              localDataSource.cacheSearchResults(ingredients, recipes);
              return Right(recipes);
            },
          );
        } else {
          return Left(CacheFailure());
        }
      },
          (localRecipes) { // This is the Right case
        return Right(localRecipes);
      },
    );
  }
}
