import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/error/failure.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/add_favorite.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/is_favorite.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorite_event.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorite_state.dart';
import '../../domain/usecases/get_favorite.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavorites getFavorites;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final IsFavorite isFavorite;

  FavoriteBloc({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
    required this.isFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoritesLoading());
      final result = await getFavorites();
      result.fold(
            (failure) => emit(FavoritesError(_mapFailureToMessage(failure))),
            (recipes) => emit(FavoritesLoaded(recipes)),
      );
    });

    on<AddRecipeToFavorites>((event, emit) async {
      final result = await addFavorite(event.recipe);
      result.fold(
            (failure) => emit(FavoritesError(_mapFailureToMessage(failure))),
            (_) => add(CheckIfFavorite(event.recipe.id)),
      );
    });

    on<RemoveRecipeFromFavorites>((event, emit) async {
      final result = await removeFavorite(event.recipeId);
      result.fold(
            (failure) => emit(FavoritesError(_mapFailureToMessage(failure))),
            (_) => add(CheckIfFavorite(event.recipeId)),
      );
    });

    on<CheckIfFavorite>((event, emit) async {
      final result = await isFavorite(event.recipeId);
      result.fold(
            (failure) => emit(FavoritesError(_mapFailureToMessage(failure))),
            (isFav) => emit(FavoriteStatus(isFav)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is GeneralFailure) {
      return failure.message;
    }
    return 'Unexpected error';
  }
}
