import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> addFavorite(Recipe recipe);
  Future<Either<Failure, void>> removeFavorite(int recipeId);
  Future<Either<Failure, List<Recipe>>> getFavorites();
  Future<Either<Failure, bool>> isFavorite(int recipeId);
}
