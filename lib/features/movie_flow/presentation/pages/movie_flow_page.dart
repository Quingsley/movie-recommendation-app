import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/genre/presentation/cubit/genre_cubit.dart';
import 'package:movie_app/features/genre/presentation/pages/genre_screen.dart';
import 'package:movie_app/features/landing/landing_page.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';
import 'package:movie_app/features/rating/cubit/rating_cubit.dart';
import 'package:movie_app/features/rating/pages/rating_screen.dart';
import 'package:movie_app/features/results/presentation/cubit/results_cubit.dart';
import 'package:movie_app/features/years_back/cubit/years_back_cubit.dart';
import 'package:movie_app/features/years_back/pages/years_back_screen.dart';
import 'package:movie_app/injection.dart';

class MovieFlow extends StatelessWidget {
  const MovieFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: BlocProvider.of<MovieFlowCubit>(context).state.controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const LandingPage(),
        BlocProvider(
            create: (_) => serviceLocator<GenreCubit>(),
            child: const GenreScreen()),
        BlocProvider(
            create: (_) => serviceLocator<RatingCubit>(),
            child: const RatingScreen()),

        MultiBlocProvider(
          providers: [
            BlocProvider<YearsBackCubit>(
              create: (BuildContext context) =>
                  serviceLocator<YearsBackCubit>(),
            ),
            BlocProvider<GenreCubit>(
              create: (BuildContext context) => serviceLocator<GenreCubit>(),
            ),
            BlocProvider<RatingCubit>(
              create: (BuildContext context) => serviceLocator<RatingCubit>(),
            ),
            BlocProvider<ResultsCubit>(
              create: (BuildContext context) => serviceLocator<ResultsCubit>(),
            ),
          ],
          child: const YearsBackScreen(),
        ),
        // BlocProvider(
        //     create: (_) => serviceLocator<YearsBackCubit>(),
        //     child: const YearsBackScreen()),
      ],
    );
  }
}
