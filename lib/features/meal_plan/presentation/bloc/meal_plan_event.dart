
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';

sealed class MealPlanEvent extends Equatable {
  const MealPlanEvent();

  @override
  List<Object> get props => [];
}

class LoadMealPlan extends MealPlanEvent {}

class AddRecipeToMealPlan extends MealPlanEvent {
  final MealPlanItem item;
  const AddRecipeToMealPlan(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveRecipeFromMealPlan extends MealPlanEvent {
  final MealPlanItem item;
  const RemoveRecipeFromMealPlan(this.item);

  @override
  List<Object> get props => [item];
}