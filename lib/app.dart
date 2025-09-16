import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/di/injection_container.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';
import 'package:recipe_finder/features/recipe_search/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_finder/features/main/main_page.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<RecipeSearchBloc>()),
        BlocProvider(create: (_) => getIt<FavoriteBloc>()),
        BlocProvider(create: (_) => getIt<MealPlanBloc>()),
      ],
      child: const MaterialApp(
        title: 'Recipe Finder',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home: MainPage(),
      ),
    );
  }
}
