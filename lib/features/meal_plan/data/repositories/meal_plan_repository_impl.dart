
import 'package:recipe_finder/features/meal_plan/data/datasources/meal_plan_local_data_source.dart';
import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class MealPlanRepositoryImpl implements MealPlanRepository {
  final MealPlanLocalDataSource localDataSource;

  MealPlanRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addToMealPlan(MealPlanItem item) {
    return localDataSource.addToMealPlan(item);
  }

  @override
  Future<List<MealPlanItem>> getMealPlanForDateRange(DateTime start, DateTime end) {
    return localDataSource.getMealPlanForDateRange(start, end);
  }

  @override
  Future<void> removeFromMealPlan(MealPlanItem item) {
    return localDataSource.removeFromMealPlan(item);
  }
}