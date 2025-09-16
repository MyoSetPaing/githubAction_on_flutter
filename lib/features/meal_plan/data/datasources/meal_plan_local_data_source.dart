import 'package:hive/hive.dart';
import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';

abstract class MealPlanLocalDataSource {
  Future<void> addToMealPlan(MealPlanItem item);
  Future<void> removeFromMealPlan(MealPlanItem item);
  Future<List<MealPlanItem>> getMealPlanForDateRange(DateTime start, DateTime end);
}

class MealPlanLocalDataSourceImpl implements MealPlanLocalDataSource {
  final Box<MealPlanItem> mealPlanBox;

  MealPlanLocalDataSourceImpl({required this.mealPlanBox});

  @override
  Future<void> addToMealPlan(MealPlanItem item) async {
    final key = '${item.date.toIso8601String().substring(0, 10)}:${item.recipe.id}';
    await mealPlanBox.put(key, item);
  }

  @override
  Future<void> removeFromMealPlan(MealPlanItem item) async {
    final key = '${item.date.toIso8601String().substring(0, 10)}:${item.recipe.id}';
    await mealPlanBox.delete(key);
  }

  @override
  Future<List<MealPlanItem>> getMealPlanForDateRange(DateTime start, DateTime end) async {
    return mealPlanBox.values.where((item) {
      return (item.date.isAfter(start) || item.date.isAtSameMomentAs(start)) &&
          (item.date.isBefore(end) || item.date.isAtSameMomentAs(end));
    }).toList();
  }
}