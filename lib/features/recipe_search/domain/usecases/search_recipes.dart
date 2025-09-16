import 'package:dartz/dartz.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';
import '../../../../core/error/failure.dart';
import '../repositories/recipes_repository.dart';


class SearchRecipes {
  final RecipeRepository repository;

  SearchRecipes(this.repository);

  Future<Either<Failure, List<Recipe>>> call(
    String ingredients) async {
    if (ingredients.isEmpty) {
      return const Right([]);
    }
    return await repository.searchRecipes(ingredients);
  }
}
