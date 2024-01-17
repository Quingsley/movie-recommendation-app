import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/results/data/datasources/movie_data_source.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';
import 'package:movie_app/features/results/domain/repositories/imovie_repository.dart';

class MovieRepository implements IMovieRepository {
  final MovieDataSource movieDataSource;

  MovieRepository({required this.movieDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> getRecommendedMovie(
      String date, String genreIds, double rating) async {
    try {
      final results =
          await movieDataSource.getRecommendedMovie(date, genreIds, rating);
      return right(results);
    } catch (e) {
      if (e is Failure) return left(e);
      return left(Failure(message: 'Something went wrong'));
    }
  }
}
