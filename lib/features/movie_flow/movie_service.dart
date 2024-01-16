import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/failure.dart';
import 'package:movie_app/features/movie_flow/genre/genre.dart';
import 'package:movie_app/features/movie_flow/movie_repository.dart';
import 'package:movie_app/features/movie_flow/results/movie.dart';

abstract class MovieService {
  Future<Either<Failure, List<Genre>>> getGenres();
  Future<Either<Failure, Movie>> getRecommendedMovies(
      List<Genre> genres, int rating, int yearsBack,
      [DateTime? yearsBackFromDate]);
}

class TMDBMovieService implements MovieService {
  final MovieRepository _movieRepository;
  TMDBMovieService(
    this._movieRepository,
  );

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    try {
      final genres = await _movieRepository.getMovieGenres();

      return right(genres.map((e) => Genre.fromEntity(e)).toList());
    } on Failure catch (failure) {
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, Movie>> getRecommendedMovies(
      List<Genre> genres, int rating, int yearsBack,
      [DateTime? yearsBackFromDate]) async {
    final date = yearsBackFromDate ?? DateTime.now();
    final year = date.year - yearsBack;
    final genreIds = genres.map((e) => e.id).toList().join(',');
    try {
      final movies = await _movieRepository.getRecommendedMovies(
          '$year-01-01', genreIds, rating.toDouble());

      if (movies.isEmpty) return left(Failure(message: 'No movies found'));

      final recommendedMovies =
          movies.map((e) => Movie.fromEntity(e, genres)).toList();
      var random = Random();
      var radomInt = random.nextInt(recommendedMovies.length);
      return right(recommendedMovies[radomInt]);
    } on Failure catch (failure) {
      return left(failure);
    }
  }
}

final movieServiceProvider = Provider((ref) {
  final movieRepository = ref.watch(tmdbMovieRepositoryProvider);
  return TMDBMovieService(movieRepository);
});
