import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/env_variables.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/genre/data/models/genre_model.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';

abstract class GenreDataSource {
  Future<List<GenreEntity>> getGenres();
}

@Injectable(as: GenreDataSource)
class GenreDataSourceImpl extends GenreDataSource {
  final Dio client;

  GenreDataSourceImpl({required this.client});

  @override
  Future<List<GenreEntity>> getGenres() async {
    try {
      if (apiKey.isEmpty) {
        throw AssertionError('TMDB_KEY is not set');
      }
      var response = await client.get('/genre/movie/list', queryParameters: {
        'api_key': apiKey,
        'language': 'en-US',
      });

      var results = response.data['genres'] as List<dynamic>;

      return results.map((e) => GenreModel.fromJson(e)).toList();
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
    }
  }
}
