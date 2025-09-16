import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/recipe_detail/domain/usecases/get_recipe_detail.dart';
import 'package:recipe_finder/features/recipe_detail/presentation/bloc/recipe_detail_state.dart';
import 'package:recipe_finder/features/recipe_detail/presentation/bloc/repice_detail_event.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeDetail getRecipeDetail;

  RecipeDetailBloc({required this.getRecipeDetail})
    : super(RecipeDetailInitial()) {
    on<GetRecipeDetailRequested>((event, emit) async {
      emit(RecipeDetailLoading());
      final result = await getRecipeDetail(event.id);
      result.fold(
        (failure) => emit(RecipeDetailError(failure.toString())),
        (recipeDetail) => emit(RecipeDetailLoaded(recipeDetail)),
      );
    });
  }
}
