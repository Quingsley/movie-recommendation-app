import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie_flow/genre/genre_screen.dart';
import 'package:movie_app/features/movie_flow/landing/landing_page.dart';
import 'package:movie_app/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_app/features/movie_flow/rating/rating_screen.dart';
import 'package:movie_app/features/movie_flow/years_back/years_back_screen.dart';

class MovieFlow extends ConsumerWidget {
  const MovieFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var movieFlowController = ref.watch(movieFlowControlProvider);
    return PageView(
      controller: movieFlowController.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        LandingPage(),
        GenreScreen(),
        RatingScreen(),
        YearsBackScreen(),
      ],
    );
  }
}
