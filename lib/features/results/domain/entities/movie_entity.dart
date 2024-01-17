import 'package:equatable/equatable.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';

class MovieEntity extends Equatable {
  final String title;
  final String overView;
  final String releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final List<GenreEntity> genres;
  final List<int> genreIds;
  final int voteAverage;

  const MovieEntity(
      {required this.title,
      required this.overView,
      required this.releaseDate,
      this.posterPath,
      this.backdropPath,
      this.genres = const [],
      required this.voteAverage,
      required this.genreIds});

  String getGenresCommaSeparated() =>
      genres.map((genre) => genre.name).toList().join(', ');

  MovieEntity copyWith(
      {String? title,
      String? overView,
      String? releaseDate,
      String? posterPath,
      String? backdropPath,
      List<GenreEntity>? genres,
      List<int>? genreIds,
      int? voteAverage}) {
    return MovieEntity(
        title: title ?? this.title,
        overView: overView ?? this.overView,
        releaseDate: releaseDate ?? this.releaseDate,
        voteAverage: voteAverage ?? this.voteAverage,
        genreIds: genreIds ?? this.genreIds,
        backdropPath: backdropPath ?? this.backdropPath,
        posterPath: posterPath ?? this.posterPath,
        genres: genres ?? this.genres);
  }

  @override
  List<Object?> get props => [
        title,
        overView,
        releaseDate,
        posterPath,
        backdropPath,
        genres,
        voteAverage,
      ];

  @override
  bool? get stringify => true;
}
