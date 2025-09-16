
import 'package:recipe_finder/features/recipe_detail/data/models/ingredient_model.dart';
import 'package:recipe_finder/features/recipe_detail/domain/entities/recipe_detail.dart';

class RecipeDetailModel extends RecipeDetail {
  const RecipeDetailModel({
    required super.id,
    required super.title,
    required super.image,
    required super.readyInMinutes,
    required super.summary,
    required super.instructions,
    required List<IngredientModel> super.extendedIngredients,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    var ingredientsList = json['extendedIngredients'] as List;
    List<IngredientModel> ingredients =
    ingredientsList.map((i) => IngredientModel.fromJson(i)).toList();

    return RecipeDetailModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      summary: json['summary'],
      instructions: json['instructions'] ?? '',
      extendedIngredients: ingredients,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'readyInMinutes': readyInMinutes,
      'summary': summary,
      'instructions': instructions,
      'extendedIngredients': extendedIngredients.map((i) => (i as IngredientModel).toJson()).toList(),
    };
  }
}