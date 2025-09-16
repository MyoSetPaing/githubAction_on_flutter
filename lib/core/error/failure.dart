import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String? message;
  const ServerFailure({this.message});
}

class CacheFailure extends Failure {}

class GeneralFailure extends Failure {
  final String message;
  const GeneralFailure({required this.message});
}
