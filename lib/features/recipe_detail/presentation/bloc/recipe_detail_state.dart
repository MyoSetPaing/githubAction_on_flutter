import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/recipe_detail/domain/entities/recipe_detail.dart';

sealed class RecipeDetailState extends Equatable {
  const RecipeDetailState();

  @override
  List<Object> get props => [];
}

final class RecipeDetailInitial extends RecipeDetailState {}

final class RecipeDetailLoading extends RecipeDetailState {}

final class RecipeDetailLoaded extends RecipeDetailState {
  final RecipeDetail recipeDetail;

  const RecipeDetailLoaded(this.recipeDetail);

  @override
  List<Object> get props => [recipeDetail];
}

final class RecipeDetailError extends RecipeDetailState {
  final String message;

  const RecipeDetailError(this.message);

  @override
  List<Object> get props => [message];
}