import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipe_search/domain/repositories/recipes_repository.dart';
import 'package:recipe_finder/features/recipe_search/domain/usecases/search_recipes.dart';

import 'recipe_search_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late SearchRecipes usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = SearchRecipes(mockRecipeRepository);
  });

  final tQuery = 'chicken,pasta';
  final tRecipeList = [
    Recipe(id: 1, title: 'Chicken Pasta', image: 'image.url', usedIngredientCount: 2, missedIngredientCount: 1),
  ];

  test(
    'should get recipes from the repository for the given query',
        () async {
      // arrange
      when(mockRecipeRepository.searchRecipes(any))
          .thenAnswer((_) async => Right(tRecipeList));
      // act
      final result = await usecase(tQuery);
      // assert
      expect(result, Right(tRecipeList));
      verify(mockRecipeRepository.searchRecipes(tQuery));
      verifyNoMoreInteractions(mockRecipeRepository);
    },
  );
}
