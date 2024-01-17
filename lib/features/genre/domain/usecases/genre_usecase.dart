import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';
import 'package:movie_app/features/genre/domain/repositories/igenre_repository.dart';

class GenreUseCase {
  final IGenreRepository genreRepository;

  GenreUseCase({required this.genreRepository});

  Future<Either<Failure, List<GenreEntity>>> getGenres() async {
    return await genreRepository.getGenres();
  }
}
