import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';

abstract class MealPlanRepository {
  Future<void> addToMealPlan(MealPlanItem item);
  Future<void> removeFromMealPlan(MealPlanItem item);
  Future<List<MealPlanItem>> getMealPlanForDateRange(DateTime start, DateTime end);
}