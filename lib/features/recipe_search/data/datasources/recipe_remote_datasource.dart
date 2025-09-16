import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:recipe_finder/core/constant/api_constant.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/recipe_search/data/models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<Either<Failure, List<RecipeModel>>> searchRecipes(String ingredients);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final Dio dio;
  RecipeRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, List<RecipeModel>>> searchRecipes(
      String ingredients,
      ) async {
    try {
      final response = await dio.get(
        ApiConstant.baseUrl + ApiConstant.searchRecipesEndpoint,
        queryParameters: {
          'apiKey': ApiConstant.apiKey,
          'ingredients': ingredients,
          'number': 20,
          'ranking': 1,
        },
      );

      if (response.statusCode == 200) {
        final recipes = (response.data as List)
            .map((json) => RecipeModel.fromJson(json))
            .toList();
        return Right(recipes);
      } else {
        return Left(ServerFailure(message: 'Status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
