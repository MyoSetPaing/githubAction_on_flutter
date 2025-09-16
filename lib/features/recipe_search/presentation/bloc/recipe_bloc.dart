import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/recipe_search/domain/usecases/search_recipes.dart';
import 'package:recipe_finder/features/recipe_search/presentation/bloc/recipe_search_event.dart';
import 'package:recipe_finder/features/recipe_search/presentation/bloc/recipe_search_state.dart';
import '../../../../core/error/failure.dart';

class RecipeSearchBloc extends Bloc<RecipeSearchEvent, RecipeSearchState> {
  final SearchRecipes searchRecipes;

  RecipeSearchBloc({required this.searchRecipes})
    : super( RecipeSearchInitial()) {
    on<SearchSubmitted>(_onSearchSubmitted);
    on<RefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onSearchSubmitted(
      SearchSubmitted event,
      Emitter<RecipeSearchState> emit,
      ) async {
    emit(RecipeSearchLoading());
    final result = await searchRecipes(event.ingredients);
    result.fold(
          (failure) => emit(RecipeSearchFailure(_mapFailureToMessage(failure))),
          (recipes) => emit(RecipeSearchSuccess(recipes)),
    );
  }

  Future<void> _onRefreshRequested(
      RefreshRequested event,
      Emitter<RecipeSearchState> emit,
      ) async {
    emit(RecipeSearchLoading());
    final result = await searchRecipes(event.ingredients);
    result.fold(
          (failure) => emit(RecipeSearchFailure(_mapFailureToMessage(failure))),
          (recipes) => emit(RecipeSearchSuccess(recipes)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure(message: final msg?):
        return msg;
      case ServerFailure():
        return 'An unexpected server error occurred.';
      case CacheFailure():
        return 'Cache Error';
      case GeneralFailure():
        return 'An unexpected error occurred.';
    }
  }
}
