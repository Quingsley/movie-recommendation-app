import 'package:flutter/foundation.dart';

@immutable
class MovieEntity {
  const MovieEntity(
      {required this.title,
      required this.overView,
      required this.releaseDate,
      this.posterPath,
      this.backdropPath,
      required this.genreIds,
      required this.voteAverage});

  final String title;
  final String overView;
  final String releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final List<int> genreIds;
  final int voteAverage;

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "genre_ids": List genreIds,
          "overview": String overView,
          "release_date": String releaseDate,
          "title": String title,
          "vote_average": dynamic voteAverage,
        }) {
      return MovieEntity(
        title: title,
        overView: overView,
        releaseDate: releaseDate,
        genreIds: List.from(genreIds),
        voteAverage: voteAverage.toInt(),
        posterPath: json['poster_path'] as String?,
        backdropPath: json['backdrop_path'] as String?,
      );
    } else {
      throw FormatException('Invalid Json format $json');
    }
  }

  @override
  String toString() {
    return 'MovieEntity(title: $title, overView: $overView, posterPath: $posterPath, backdropPath: $backdropPath ,releaseDate: $releaseDate, genreIds: $genreIds, voteAverage: $voteAverage,)';
  }

  @override
  bool operator ==(covariant MovieEntity other) {
    return title == other.title &&
        overView == other.overView &&
        posterPath == other.posterPath &&
        backdropPath == other.backdropPath &&
        releaseDate == other.releaseDate &&
        genreIds == other.genreIds &&
        voteAverage == other.voteAverage;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      overView.hashCode ^
      posterPath.hashCode ^
      backdropPath.hashCode ^
      releaseDate.hashCode ^
      genreIds.hashCode ^
      voteAverage.hashCode;
}
