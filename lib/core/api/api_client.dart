import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/genre/data/models/genre_model.dart';
import 'package:movie_app/features/results/data/models/movie_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@Injectable()
@RestApi(baseUrl: 'https://api.themoviedb.org/3')
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/genre/movie/list')
  Future<GenresResponse> getGenres(
      @Query('api_key') String apiKey, @Query('language') String language);

  @GET('/discover/movie')
  Future<MovieResponse> getRecommendedMovie(
      @Queries() Map<String, dynamic> queries);
}
