import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class RemoveFromMealPlan {
  final MealPlanRepository repository;
  RemoveFromMealPlan(this.repository);

  Future<void> call(MealPlanItem item) async {
    await repository.removeFromMealPlan(item);
  }
}