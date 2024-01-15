import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie_flow/genre/genre.dart';
import 'package:movie_app/features/movie_flow/movie_repository.dart';
import 'package:movie_app/features/movie_flow/results/movie.dart';

abstract class MovieService {
  Future<List<Genre>> getGenres();
  Future<Movie> getRecommendedMovies(
      List<Genre> genres, int rating, int yearsBack,
      [DateTime? yearsBackFromDate]);
}

class TMDBMovieService implements MovieService {
  final MovieRepository _movieRepository;
  TMDBMovieService(
    this._movieRepository,
  );

  @override
  Future<List<Genre>> getGenres() async {
    final genres = await _movieRepository.getMovieGenres();

    return genres.map((e) => Genre.fromEntity(e)).toList();
  }

  @override
  Future<Movie> getRecommendedMovies(
      List<Genre> genres, int rating, int yearsBack,
      [DateTime? yearsBackFromDate]) async {
    final date = yearsBackFromDate ?? DateTime.now();
    final year = date.year - yearsBack;
    final genreIds = genres.map((e) => e.id).toList().join(',');
    final movies = await _movieRepository.getRecommendedMovies(
        '$year-01-01', genreIds, rating.toDouble());

    final recommendedMovies =
        movies.map((e) => Movie.fromEntity(e, genres)).toList();
    var random = Random();
    var radomInt = random.nextInt(recommendedMovies.length);
    return recommendedMovies[radomInt];
  }
}

final movieServiceProvider = Provider((ref) {
  final movieRepository = ref.watch(tmdbMovieRepositoryProvider);
  return TMDBMovieService(movieRepository);
});
