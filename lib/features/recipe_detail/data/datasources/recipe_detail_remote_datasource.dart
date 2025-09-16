import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:recipe_finder/core/constant/api_constant.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/recipe_detail/data/models/recipe_detail_model.dart';

abstract class RecipeDetailRemoteDataSource {
  Future<Either<Failure, RecipeDetailModel>> getRecipeDetail(int id);
}

class RecipeDetailRemoteDataSourceImpl implements RecipeDetailRemoteDataSource {
  final Dio dio;

  RecipeDetailRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, RecipeDetailModel>> getRecipeDetail(int id) async {
    try {
      final response = await dio.get(
        '${ApiConstant.baseUrl + ApiConstant.recipeDetailEndpoint}/$id/information',
        queryParameters: {'apiKey': ApiConstant.apiKey},
      );

      if (response.statusCode == 200) {
        return Right(RecipeDetailModel.fromJson(response.data));
      } else {
        return const  Left(GeneralFailure(message: 'Failed to load recipe detail'));
      }
    } on DioException {
      return  const Left(GeneralFailure(message: 'Failed to load recipe detail'));
    }
  }
}
