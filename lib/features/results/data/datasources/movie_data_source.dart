import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_app/core/env_variables.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/results/data/models/movie_model.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';

abstract class MovieDataSource {
  Future<List<MovieEntity>> getRecommendedMovie(
      String date, String genreIds, double rating);
}

class MovieDataSourceImpl extends MovieDataSource {
  final Dio client;

  MovieDataSourceImpl({required this.client});

  @override
  Future<List<MovieEntity>> getRecommendedMovie(
      String date, String genreIds, double rating) async {
    try {
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
      final movies = results.map((e) => MovieModel.fromJson(e)).toList();
      if (movies.isEmpty) throw Exception('No movies found');
      return movies;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Failure(
            message: 'No internet connection',
            exception: e,
            code: e.response?.statusCode);
      }
      throw Failure(
          message: e.response?.statusMessage ?? 'Something went wrong',
          exception: e,
          code: e.response?.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}
