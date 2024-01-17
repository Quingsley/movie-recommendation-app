import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';
import 'package:movie_app/features/results/domain/usecases/movie_usecase.dart';

part 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit({required this.movieUseCase}) : super(ResultsInitial());

  final MovieUseCase movieUseCase;

  Future<void> getRecommendedMovie(
      List<GenreEntity> genres, int rating, int yearsBack,
      [DateTime? yearsBackFromDate]) async {
    final date = yearsBackFromDate ?? DateTime.now();
    final year = date.year - yearsBack;
    final genreIds = genres.map((e) => e.id).toList().join(',');

    emit(ResultsLoadingState());
    final result = await movieUseCase.getRecommendedMovie(
        '$year-01-01', genreIds, rating.toDouble());

    result.fold((error) => emit(ResultsErrorState(message: error.message)),
        (movie) {
      print(movie);
      final movieGenres =
          genres.where((genre) => movie.genreIds.contains(genre.id)).toList();
      movie = movie.copyWith(genres: movieGenres);
      emit(ResultsLoadedState(movieEntity: movie));
    });
  }
}
