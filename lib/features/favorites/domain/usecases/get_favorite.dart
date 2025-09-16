import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

class GetFavorites {
  final FavoriteRepository repository;
  GetFavorites(this.repository);

  Future<Either<Failure, List<Recipe>>> call() async {
    return await repository.getFavorites();
  }
}
