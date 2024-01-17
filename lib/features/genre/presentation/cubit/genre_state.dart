part of 'genre_cubit.dart';

abstract class GenreState extends Equatable {
  const GenreState({required this.genres});
  final List<GenreEntity> genres;

  @override
  List<Object> get props => [genres];
}

class GenreInitial extends GenreState {
  const GenreInitial({required super.genres});
}

class GenreLoadingState extends GenreState {
  const GenreLoadingState({required super.genres});
}

class GenreLoadedState extends GenreState {
  const GenreLoadedState({required super.genres});

  @override
  List<Object> get props => [genres];
}

class GenreErrorState extends GenreState {
  final String message;

  const GenreErrorState({required this.message, super.genres = const []});

  @override
  List<Object> get props => [message];
}
