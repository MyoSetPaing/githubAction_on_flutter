import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';

sealed class MealPlanState extends Equatable {
  const MealPlanState();

  @override
  List<Object> get props => [];
}

final class MealPlanInitial extends MealPlanState {}

final class MealPlanLoading extends MealPlanState {}

final class MealPlanLoaded extends MealPlanState {
  final Map<DateTime, List<MealPlanItem>> mealPlan;

  const MealPlanLoaded(this.mealPlan);

  @override
  List<Object> get props => [mealPlan];
}

final class MealPlanError extends MealPlanState {
  final String message;

  const MealPlanError(this.message);

  @override
  List<Object> get props => [message];
}