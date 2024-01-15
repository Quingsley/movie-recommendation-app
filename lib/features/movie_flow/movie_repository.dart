import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/env_variables.dart';
import 'package:movie_app/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_app/features/movie_flow/results/movie_entity.dart';
import 'package:movie_app/main.dart';

abstract class MovieRepository {
  Future<List<GenreEntity>> getMovieGenres();
  Future<List<MovieEntity>> getRecommendedMovies(
      String date, String genreIds, double rating);
}

class TMDBMovieRepository implements MovieRepository {
  TMDBMovieRepository({required this.client});
  final Dio client;

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    if (apiKey.isEmpty) {
      throw AssertionError('TMDB_KEY is not set');
    }
    var response = await client.get('/genre/movie/list', queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
    });

    var results = response.data['genres'] as List<dynamic>;

    return results.map((e) => GenreEntity.fromJson(e)).toList();
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      String date, String genreIds, double rating) async {
    if (apiKey.isEmpty) {
      throw AssertionError('TMDB_KEY is not set');
    }
    var response = await client.get('/discover/movie', queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
      'sort_by': 'popularity.desc',
      'include_adult': false,
      'vote_average.gte': rating,
      'page': 1,
      'release_date.gte': date,
      'with_genres': genreIds,
    });

    var results = response.data['results'] as List<dynamic>;
    return results.map((e) => MovieEntity.fromJson(e)).toList();
  }
}

final tmdbMovieRepositoryProvider = Provider<MovieRepository>((ref) {
  final client = ref.watch(dioProvider);
  return TMDBMovieRepository(client: client);
});
