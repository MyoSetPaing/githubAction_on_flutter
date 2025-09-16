import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/app.dart';

import 'core/di/injection_container.dart' as di;
import 'features/meal_plan/domain/entities/meal_plan_adapter.dart';
import 'features/recipe_search/data/models/recipe_adapter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(MealPlanItemAdapter());
  await di.init();
  runApp(const RecipeApp());
}