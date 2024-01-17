part of 'movie_flow_cubit.dart';

abstract class MovieFlowState extends Equatable {
  final PageController controller;
  const MovieFlowState(this.controller);

  @override
  List<Object> get props => [controller];
}

class MovieFlowInitial extends MovieFlowState {
  const MovieFlowInitial(super.controller);
}
