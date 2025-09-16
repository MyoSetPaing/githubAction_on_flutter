import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class AddToMealPlan {
  final MealPlanRepository repository;
  AddToMealPlan(this.repository);

  Future<void> call(MealPlanItem item) async {
    await repository.addToMealPlan(item);
  }
}