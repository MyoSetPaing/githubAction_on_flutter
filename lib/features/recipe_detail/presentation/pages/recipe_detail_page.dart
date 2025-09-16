import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_finder/features/recipe_detail/presentation/bloc/recipe_detail_state.dart';

import '../../../../core/di/injection_container.dart';
import '../../../favorites/presentation/bloc/favorite_bloc.dart';
import '../../../favorites/presentation/bloc/favorite_event.dart';
import '../../../favorites/presentation/bloc/favorite_state.dart';
import '../../../recipe_search/domain/entities/recipe.dart';
import '../bloc/repice_detail_event.dart';

class RecipeDetailPage extends StatelessWidget {
  final int recipeId;

  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<RecipeDetailBloc>()..add(GetRecipeDetailRequested(recipeId)),
        ),
        BlocProvider(
          create: (_) => getIt<FavoriteBloc>()..add(CheckIfFavorite(recipeId)),
        ),
      ],
      child: const RecipeDetailView(),
    );
  }
}

class RecipeDetailView extends StatelessWidget {
  const RecipeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
        actions: [
          BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
            builder: (context, detailState) {
              if (detailState is RecipeDetailLoaded) {
                return BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, favoriteState) {
                    bool isFavorite = false;
                    if (favoriteState is FavoriteStatus) {
                      isFavorite = favoriteState.isFavorite;
                    }
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        final recipe = detailState.recipeDetail;
                        final favoriteBloc = context.read<FavoriteBloc>();
                        if (isFavorite) {
                          favoriteBloc.add(
                            RemoveRecipeFromFavorites(recipe.id),
                          );
                        } else {
                          // We need to convert RecipeDetail to Recipe for saving
                          final simpleRecipe = Recipe(
                            id: recipe.id,
                            title: recipe.title,
                            image: recipe.image,
                            usedIngredientCount: 0,
                            // Not available here
                            missedIngredientCount: 0, // Not available here
                          );
                          favoriteBloc.add(AddRecipeToFavorites(simpleRecipe));
                        }
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
        builder: (context, state) {
          if (state is RecipeDetailLoading || state is RecipeDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RecipeDetailLoaded) {
            final detail = state.recipeDetail;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: detail.image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text('Ready in ${detail.readyInMinutes} minutes'),
                        const SizedBox(height: 16),
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (var ingredient in detail.extendedIngredients)
                          Text(
                            '• ${ingredient.amount} ${ingredient.unit} ${ingredient.name}',
                          ),
                        const SizedBox(height: 16),
                        const Text(
                          'Instructions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          detail.instructions.replaceAll(
                            RegExp(r'<[^>]*>'),
                            '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is RecipeDetailError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
