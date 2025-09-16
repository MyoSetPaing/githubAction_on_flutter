import 'package:hive/hive.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

abstract class FavoriteLocalDataSource {
  Future<void> addFavorite(Recipe recipe);
  Future<void> removeFavorite(int recipeId);
  Future<List<Recipe>> getFavorites();
  Future<bool> isFavorite(int recipeId);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final Box<Recipe> favoriteBox;

  FavoriteLocalDataSourceImpl({required this.favoriteBox});

  @override
  Future<void> addFavorite(Recipe recipe) async {
    await favoriteBox.put(recipe.id, recipe);
  }

  @override
  Future<List<Recipe>> getFavorites() async {
    return favoriteBox.values.toList();
  }

  @override
  Future<bool> isFavorite(int recipeId) async {
    return favoriteBox.containsKey(recipeId);
  }

  @override
  Future<void> removeFavorite(int recipeId) async {
    await favoriteBox.delete(recipeId);
  }
}