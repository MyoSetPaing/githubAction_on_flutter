import 'package:dartz/dartz.dart';
import 'package:recipe_finder/features/favorites/domain/repositories/favorite_repository.dart';

import '../../../../core/error/failure.dart';

class IsFavorite {
  final FavoriteRepository repository;
  IsFavorite(this.repository);

  Future<Either<Failure, bool>> call(int recipeId) async {
    return await repository.isFavorite(recipeId);
  }
}