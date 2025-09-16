
import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final String name;
  final String amount;
  final String unit;

  const Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
  });

  @override
  List<Object?> get props => [name, amount, unit];
}