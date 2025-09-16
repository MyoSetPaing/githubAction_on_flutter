import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoriteEvent {}

class AddRecipeToFavorites extends FavoriteEvent {
  final Recipe recipe;

  const AddRecipeToFavorites(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class RemoveRecipeFromFavorites extends FavoriteEvent {
  final int recipeId;

  const RemoveRecipeFromFavorites(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}

class CheckIfFavorite extends FavoriteEvent {
  final int recipeId;

  const CheckIfFavorite(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}