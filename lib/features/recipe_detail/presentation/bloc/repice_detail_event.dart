
import 'package:equatable/equatable.dart';

sealed class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object> get props => [];
}

class GetRecipeDetailRequested extends RecipeDetailEvent {
  final int id;

  const GetRecipeDetailRequested(this.id);

  @override
  List<Object> get props => [id];
}