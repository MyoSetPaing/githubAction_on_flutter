
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/recipe_detail/domain/entities/ingredient.dart';

class RecipeDetail extends Equatable {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final String summary;
  final String instructions;
  final List<Ingredient> extendedIngredients;

  const RecipeDetail({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.summary,
    required this.instructions,
    required this.extendedIngredients,
  });

  @override
  List<Object?> get props => [id, title, image, readyInMinutes, summary, instructions, extendedIngredients];
}