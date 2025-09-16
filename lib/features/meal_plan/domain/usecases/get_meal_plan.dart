import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class GetMealPlan {
  final MealPlanRepository repository;
  GetMealPlan(this.repository);

  Future<List<MealPlanItem>> call(DateTime start, DateTime end) async {
    return await repository.getMealPlanForDateRange(start, end);
  }
}