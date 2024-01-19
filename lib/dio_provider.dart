import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: Dio)
@module
abstract class DioProvider {
  @singleton
  Dio dio() => Dio(
        BaseOptions(
            baseUrl: 'https://api.themoviedb.org/3',
            connectTimeout: const Duration(seconds: 10),
            headers: {'Content-Type': 'application/json'}),
      );
}
