import 'package:equatable/equatable.dart';

sealed class RecipeSearchEvent extends Equatable {
  const RecipeSearchEvent();

  @override
  List<Object> get props => [];
}

final class SearchSubmitted extends RecipeSearchEvent {
  final String ingredients;

  const SearchSubmitted(this.ingredients);

  @override
  List<Object> get props => [ingredients];
}

final class RefreshRequested extends RecipeSearchEvent {
  final String ingredients;

  const RefreshRequested(this.ingredients);

  @override
  List<Object> get props => [ingredients];
}


