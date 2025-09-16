import 'package:dartz/dartz.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';
import '../../../../core/error/failure.dart';
import '../repositories/favorite_repository.dart';

class AddFavorite {
  final FavoriteRepository repository;

  AddFavorite(this.repository);

  Future<Either<Failure, void>> call(Recipe recipe) async {
    return await repository.addFavorite(recipe);
  }
}