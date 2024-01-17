import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';

abstract class IGenreRepository {
  Future<Either<Failure, List<GenreEntity>>> getGenres();
}
