import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';
import 'package:movie_app/features/results/domain/repositories/imovie_repository.dart';

@Injectable()
class MovieUseCase {
  final IMovieRepository _movieRepository;

  MovieUseCase(this._movieRepository);

  Future<Either<Failure, MovieEntity>> getRecommendedMovie(
      String date, String genreIds, double rating) async {
    final movies =
        await _movieRepository.getRecommendedMovie(date, genreIds, rating);
// add logic to get random movie form list
    final random = Random();
    return movies.fold((error) => left(error), (movies) {
      final recommendedMovieIndex = random.nextInt(movies.length);
      return right(movies[recommendedMovieIndex]);
    });
  }
}
