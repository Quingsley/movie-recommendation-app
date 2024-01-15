import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie_flow/genre/genre.dart';
import 'package:movie_app/features/movie_flow/results/movie.dart';

const mockMovie = Movie(
    title: 'Need for speed',
    overView: 'Get in the wild west roads and buckle up for a rollercoaster',
    voteAverage: 6.5,
    genres: [Genre(name: 'Action'), Genre(name: 'Drama')],
    releaseDate: '2019-03-02',
    posterPath: '',
    backdropPath: '');

const List<Genre> mockGenres = [
  Genre(name: 'Action'),
  Genre(name: 'Horror'),
  Genre(name: 'Animation'),
  Genre(name: 'Comedy'),
  Genre(name: 'Crime'),
  Genre(name: 'Drama'),
  Genre(name: 'Family'),
  Genre(name: 'Romance'),
];

@immutable
class MovieFlowState {
  final num yearsBack;
  final num rating;
  final AsyncValue<Movie> movie;
  final AsyncValue<List<Genre>> genres;
  final PageController pageController;

  const MovieFlowState({
    this.yearsBack = 10,
    this.rating = 5,
    required this.movie,
    required this.genres,
    required this.pageController,
  });

  MovieFlowState copyWith(
      {PageController? pageController,
      num? yearsBack,
      AsyncValue<Movie>? movie,
      num? rating,
      AsyncValue<List<Genre>>? genres}) {
    return MovieFlowState(
        pageController: pageController ?? this.pageController,
        yearsBack: yearsBack ?? this.yearsBack,
        movie: movie ?? this.movie,
        rating: rating ?? this.rating,
        genres: genres ?? this.genres);
  }

  @override
  bool operator ==(covariant MovieFlowState other) {
    return pageController == other.pageController &&
        yearsBack == other.yearsBack &&
        movie == other.movie &&
        rating == other.rating &&
        genres == other.genres;
  }

  @override
  int get hashCode =>
      pageController.hashCode ^
      yearsBack.hashCode ^
      movie.hashCode ^
      rating.hashCode ^
      rating.hashCode ^
      genres.hashCode;
}
