
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

class MealPlanItem extends Equatable {
  final DateTime date;
  final Recipe recipe;

  const MealPlanItem({
    required this.date,
    required this.recipe,
  });

  @override
  List<Object?> get props => [date, recipe];
}