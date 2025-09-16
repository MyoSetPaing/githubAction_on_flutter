import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoriteState {}

final class FavoritesLoading extends FavoriteState {}

final class FavoritesLoaded extends FavoriteState {
  final List<Recipe> recipes;

  const FavoritesLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

final class FavoriteStatus extends FavoriteState {
  final bool isFavorite;

  const FavoriteStatus(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

final class FavoritesError extends FavoriteState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}