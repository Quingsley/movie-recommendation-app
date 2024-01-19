import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_client.dart';
import 'package:movie_app/core/env_variables.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';

abstract class GenreDataSource {
  Future<List<GenreEntity>> getGenres();
}

@Injectable(as: GenreDataSource)
class GenreDataSourceImpl extends GenreDataSource {
  final Dio dio;
  final ApiClient apiClient;

  GenreDataSourceImpl({required this.dio}) : apiClient = ApiClient(dio);

  @override
  Future<List<GenreEntity>> getGenres() async {
    try {
      if (apiKey.isEmpty) {
        throw AssertionError('TMDB_KEY is not set');
      }

      var results = await apiClient.getGenres(apiKey, 'en-US');

      return results.genres;
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
