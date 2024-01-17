import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';

abstract class IMovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getRecommendedMovie(
      String date, String genreIds, double rating);
}
