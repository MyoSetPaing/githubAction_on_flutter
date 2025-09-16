
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required super.id,
    required super.title,
    required super.image,
    required super.usedIngredientCount,
    required super.missedIngredientCount,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      usedIngredientCount: json['usedIngredientCount'],
      missedIngredientCount: json['missedIngredientCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'usedIngredientCount': usedIngredientCount,
      'missedIngredientCount': missedIngredientCount,
    };
  }

  RecipeModel copyWith({
    int? id,
    String? title,
    String? image,
    int? usedIngredientCount,
    int? missedIngredientCount,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      usedIngredientCount: usedIngredientCount ?? this.usedIngredientCount,
      missedIngredientCount: missedIngredientCount ?? this.missedIngredientCount,
    );
  }
}