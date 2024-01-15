import 'package:flutter/foundation.dart';
import 'package:movie_app/features/movie_flow/genre/genre.dart';
import 'package:movie_app/features/movie_flow/results/movie_entity.dart';

@immutable
class Movie {
  final String title;
  final String overView;
  final num voteAverage;
  final List<Genre> genres;
  final String releaseDate;
  final String? backdropPath;
  final String? posterPath;

  const Movie({
    required this.title,
    required this.overView,
    required this.voteAverage,
    required this.genres,
    required this.releaseDate,
    this.backdropPath,
    this.posterPath,
  });

  Movie.initial()
      : title = '',
        overView = '',
        voteAverage = 0,
        genres = [],
        releaseDate = '',
        backdropPath = '',
        posterPath = '';

  String getGenresCommaSeparated() =>
      genres.map((genre) => genre.name).toList().join(', ');

  factory Movie.fromEntity(MovieEntity entity, List<Genre> genres) {
    return Movie(
        title: entity.title,
        overView: entity.overView,
        voteAverage: entity.voteAverage,
        genres: genres
            .where((genre) => entity.genreIds.contains(genre.id))
            .toList(growable: false),
        releaseDate: entity.releaseDate,
        backdropPath:
            'https://image.tmdb.org/t/p/original/${entity.backdropPath}',
        posterPath: 'https://image.tmdb.org/t/p/original/${entity.posterPath}');
  }

  @override
  String toString() {
    return 'Movie(title: $title, overView: $overView, voteAverage: $voteAverage, genres: $genres, releaseDate: $releaseDate, backdropPath: $backdropPath, posterPath: $posterPath)';
  }

  @override
  bool operator ==(covariant Movie other) {
    return title == other.title &&
        overView == other.overView &&
        voteAverage == other.voteAverage &&
        releaseDate == other.releaseDate &&
        backdropPath == other.backdropPath &&
        posterPath == other.posterPath &&
        genres == other.genres;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      overView.hashCode ^
      voteAverage.hashCode ^
      releaseDate.hashCode ^
      backdropPath.hashCode ^
      posterPath.hashCode ^
      genres.hashCode;
}
