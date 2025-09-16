import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';

import '../../../recipe_search/domain/entities/recipe.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_data_source.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addFavorite(Recipe recipe) async {
    try {
      await localDataSource.addFavorite(recipe);
      return const Right(null);
    } catch (e) {
      return const Left(GeneralFailure(message: 'Failed to add favorite'));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getFavorites() async {
    try {
      final recipes = await localDataSource.getFavorites();
      return Right(recipes);
    } catch (e) {
      return const Left(GeneralFailure(message: 'Failed to get favorites'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(int recipeId) async {
    try {
      final result = await localDataSource.isFavorite(recipeId);
      return Right(result);
    } catch (e) {
      return const Left(GeneralFailure(message: 'Failed to check favorite'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int recipeId) async {
    try {
      await localDataSource.removeFavorite(recipeId);
      return const Right(null);
    } catch (e) {
      return const Left(GeneralFailure(message: 'Failed to remove favorite'));
    }
  }
}
