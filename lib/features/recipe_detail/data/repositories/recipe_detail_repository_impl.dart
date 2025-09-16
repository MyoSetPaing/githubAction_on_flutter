import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/recipe_detail/data/datasources/recipe_detail_remote_datasource.dart';
import 'package:recipe_finder/features/recipe_detail/data/models/recipe_detail_model.dart';
import 'package:recipe_finder/features/recipe_detail/domain/repositories/recipe_detail_repository.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  final RecipeDetailRemoteDataSource remoteDataSource;

  RecipeDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, RecipeDetailModel>> getRecipeDetail(int id) async{
    return await remoteDataSource.getRecipeDetail(id);
  }
}
