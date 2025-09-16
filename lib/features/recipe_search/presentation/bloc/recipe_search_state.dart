import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

sealed class RecipeSearchState extends Equatable {
  const RecipeSearchState();

  @override
  List<Object> get props => [];
}

final class RecipeSearchInitial extends RecipeSearchState {}

final class RecipeSearchLoading extends RecipeSearchState {}

final class RecipeSearchSuccess extends RecipeSearchState {
  final List<Recipe> recipes;

  const RecipeSearchSuccess(this.recipes);

  @override
  List<Object> get props => [recipes];
}

final class RecipeSearchFailure extends RecipeSearchState {
  final String errorMessage;

  const RecipeSearchFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}