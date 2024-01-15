import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie_flow/genre/genre.dart';
import 'package:movie_app/features/movie_flow/movie_flow_state.dart';
import 'package:movie_app/features/movie_flow/movie_service.dart';
import 'package:movie_app/features/movie_flow/results/movie.dart';

class MovieFlowController extends StateNotifier<MovieFlowState> {
  MovieFlowController(super.state, this.movieService) {
    loadGenres();
  }

  final MovieService movieService;

  toggleSelected(Genre genre) {
    state = state.copyWith(
        genres: AsyncValue.data([
      for (final oldGenre in state.genres.value!)
        if (oldGenre == genre) oldGenre.toggleSelected() else oldGenre
    ]));
  }

  void updatedRating(int updatedRating) {
    state = state.copyWith(rating: updatedRating);
  }

  void updatedYearsBack(int updatedYearsBack) {
    state = state.copyWith(yearsBack: updatedYearsBack);
  }

  void nextPage() {
    if (state.pageController.page! >= 1) {
      // if no genre is selected, don't go to the next page
      if (!state.genres.value!.any((element) => element.isSelected)) {
        return;
      }
    }
    state.pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInCubic,
    );
  }

  void previousPage() {
    state.pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
  }

  Future<void> loadGenres() async {
    state = state.copyWith(genres: const AsyncValue.loading());
    final genres = await movieService.getGenres();
    state = state.copyWith(genres: AsyncValue.data(genres));
  }

  Future<void> getRecommendedMovie() async {
    final selectedGenres =
        state.genres.value?.where((element) => element.isSelected).toList() ??
            [];
    state = state.copyWith(movie: const AsyncValue.loading());
    final movie = await movieService.getRecommendedMovies(
        selectedGenres, state.rating.toInt(), state.yearsBack.toInt());
    state = state.copyWith(movie: AsyncValue.data(movie));
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}

final movieFlowControlProvider =
    StateNotifierProvider.autoDispose<MovieFlowController, MovieFlowState>(
        (ref) {
  final movies = AsyncValue.data(Movie.initial());
  const genres = AsyncValue.data(<Genre>[]);
  final movieService = ref.watch(movieServiceProvider);
  return MovieFlowController(
      MovieFlowState(
        pageController: PageController(),
        movie: movies,
        genres: genres,
      ),
      movieService);
});
