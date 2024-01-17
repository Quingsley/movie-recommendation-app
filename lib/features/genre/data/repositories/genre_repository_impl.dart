import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/genre/data/datasources/genre_data_source.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';
import 'package:movie_app/features/genre/domain/repositories/igenre_repository.dart';

class GenreRepositoryImpl extends IGenreRepository {
  final GenreDataSource genreDataSource;

  GenreRepositoryImpl({required this.genreDataSource});

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenres() async {
    try {
      final genres = await genreDataSource.getGenres();
      return right(genres);
    } catch (e) {
      if (e is Failure) return left(e);
      return left(Failure(message: 'Something went wrong'));
    }
  }
}
