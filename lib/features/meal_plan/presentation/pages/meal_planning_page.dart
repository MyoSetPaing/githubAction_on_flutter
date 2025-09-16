import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_event.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_state.dart';

import '../widgets/meal_plan_list_item.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  @override
  void initState() {
    super.initState();
    context.read<MealPlanBloc>().add(LoadMealPlan());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Meal Plan')),
      body: BlocBuilder<MealPlanBloc, MealPlanState>(
        builder: (context, state) {
          if (state is MealPlanLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MealPlanLoaded) {
            final now = DateTime.now();
            final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

            return ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                final day = startOfWeek.add(Duration(days: index));
                final dayKey = DateTime(day.year, day.month, day.day);
                final mealsForDay = state.mealPlan[dayKey] ?? [];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, MMM d').format(day),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(),
                        if (mealsForDay.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(child: Text('No meals planned.')),
                          ),
                        ...mealsForDay.map(
                          (item) => Dismissible(
                            key: Key('${item.date}:${item.recipe.id}'),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              context.read<MealPlanBloc>().add(
                                RemoveRecipeFromMealPlan(item),
                              );
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${item.recipe.title} removed from plan',
                                    ),
                                  ),
                                );
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: MealPlanListItem(recipe: item.recipe),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is MealPlanError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Your meal plan will appear here.'));
        },
      ),
    );
  }
}
