
import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/recipe_detail/data/models/recipe_detail_model.dart';

abstract class RecipeDetailRepository {
  Future<Either<Failure, RecipeDetailModel>> getRecipeDetail(int id);
}
