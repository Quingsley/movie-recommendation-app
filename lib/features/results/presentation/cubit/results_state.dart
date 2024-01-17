part of 'results_cubit.dart';

abstract class ResultsState extends Equatable {
  const ResultsState();

  @override
  List<Object> get props => [];
}

class ResultsInitial extends ResultsState {}

class ResultsLoadingState extends ResultsState {}

class ResultsLoadedState extends ResultsState {
  final MovieEntity movieEntity;

  const ResultsLoadedState({required this.movieEntity});
}

class ResultsErrorState extends ResultsState {
  final String message;

  const ResultsErrorState({required this.message});
}
