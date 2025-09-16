import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

abstract class RecipeLocalDataSource {
  Future<Either<Failure, List<Recipe>>> getCachedSearchResults(String query);
  Future<void> cacheSearchResults(String query, List<Recipe> recipes);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box<dynamic> box;

  RecipeLocalDataSourceImpl({required this.box});

  @override
  Future<void> cacheSearchResults(String query, List<Recipe> recipes) async {
    final cacheKey = 'search_$query';
    final cacheData = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': recipes,
    };
    await box.put(cacheKey, cacheData);
  }

  @override
  Future<Either<Failure, List<Recipe>>> getCachedSearchResults(String query) async {
    final cacheKey = 'search_$query';
    final cached = box.get(cacheKey);

    if (cached != null) {
      final fetchTime = DateTime.parse(cached['timestamp'] as String);
      if (DateTime.now().difference(fetchTime).inMinutes < 30) {
        return Right((cached['data'] as List).cast<Recipe>());
      }
    }
    return Left(CacheFailure());
  }
}
