import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/genre/presentation/pages/genre_screen.dart';
import 'package:movie_app/features/landing/landing_page.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';
import 'package:movie_app/features/rating/pages/rating_screen.dart';
import 'package:movie_app/features/years_back/pages/years_back_screen.dart';

class MovieFlow extends StatelessWidget {
  const MovieFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: BlocProvider.of<MovieFlowCubit>(context).state,
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
