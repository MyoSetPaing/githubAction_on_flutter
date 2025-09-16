
import 'package:hive/hive.dart';
import 'package:recipe_finder/features/meal_plan/domain/entities/meal_plan_item.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

class MealPlanItemAdapter extends TypeAdapter<MealPlanItem> {
  @override
  final int typeId = 1;

  @override
  MealPlanItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealPlanItem(
      date: fields[0] as DateTime,
      recipe: fields[1] as Recipe,
    );
  }

  @override
  void write(BinaryWriter writer, MealPlanItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.recipe);
  }
}