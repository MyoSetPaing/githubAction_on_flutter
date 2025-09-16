import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/recipe_detail/data/models/recipe_detail_model.dart';
import 'package:recipe_finder/features/recipe_detail/domain/repositories/recipe_detail_repository.dart';

class GetRecipeDetail {
  final RecipeDetailRepository repository;

  GetRecipeDetail(this.repository);

  Future<Either<Failure, RecipeDetailModel>> call(int id) {
    return repository.getRecipeDetail(id);
  }
}
