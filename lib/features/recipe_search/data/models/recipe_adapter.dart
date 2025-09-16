
import 'package:hive/hive.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as int,
      title: fields[1] as String,
      image: fields[2] as String,
      usedIngredientCount: fields[3] as int,
      missedIngredientCount: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.usedIngredientCount)
      ..writeByte(4)
      ..write(obj.missedIngredientCount);
  }
}