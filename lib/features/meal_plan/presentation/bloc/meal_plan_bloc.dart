import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/add_to_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/get_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_event.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_state.dart';
import '../../domain/entities/meal_plan_item.dart';
import '../../domain/usecases/remove_meal_plan.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  final GetMealPlan getMealPlan;
  final AddToMealPlan addToMealPlan;
  final RemoveFromMealPlan removeFromMealPlan;

  MealPlanBloc({
    required this.getMealPlan,
    required this.addToMealPlan,
    required this.removeFromMealPlan,
  }) : super(MealPlanInitial()) {
    on<LoadMealPlan>((event, emit) async {
      emit(MealPlanLoading());
      try {
        final now = DateTime.now();
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));

        final planItems = await getMealPlan(startOfWeek, endOfWeek);

        final mealPlanMap = <DateTime, List<MealPlanItem>>{};
        for (var item in planItems) {
          final dateKey = DateTime(item.date.year, item.date.month, item.date.day);
          if (mealPlanMap[dateKey] == null) {
            mealPlanMap[dateKey] = [];
          }
          mealPlanMap[dateKey]!.add(item);
        }

        emit(MealPlanLoaded(mealPlanMap));
      } catch (e) {
        emit(MealPlanError(e.toString()));
      }
    });

    on<AddRecipeToMealPlan>((event, emit) async {
      await addToMealPlan(event.item);
      add(LoadMealPlan());
    });

    on<RemoveRecipeFromMealPlan>((event, emit) async {
      await removeFromMealPlan(event.item);
      add(LoadMealPlan());
    });
  }
}