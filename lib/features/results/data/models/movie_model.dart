import 'package:equatable/equatable.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity with EquatableMixin {
  MovieModel({
    required String title,
    required String overView,
    required String releaseDate,
    required List<int> genreIds,
    required int voteAverage,
    String? posterPath,
    String? backdropPath,
  }) : super(
          genreIds: genreIds,
          title: title,
          overView: overView,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          posterPath: posterPath,
          backdropPath: backdropPath,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "genre_ids": List genreIds,
          "overview": String overView,
          "release_date": String releaseDate,
          "title": String title,
          "vote_average": dynamic voteAverage,
        }) {
      return MovieModel(
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
}
