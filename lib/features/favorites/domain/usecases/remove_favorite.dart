import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/favorites/domain/repositories/favorite_repository.dart';

class RemoveFavorite {
  final FavoriteRepository repository;
  RemoveFavorite(this.repository);

  Future<Either<Failure, void>> call(int recipeId) async {
    return await repository.removeFavorite(recipeId);
  }
}
