import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/genre/presentation/cubit/genre_cubit.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';
import 'package:movie_app/features/movie_flow/presentation/pages/movie_flow_page.dart';
import 'package:movie_app/features/rating/cubit/rating_cubit.dart';
import 'package:movie_app/features/results/presentation/cubit/results_cubit.dart';
import 'package:movie_app/features/results/presentation/pages/results_screen.dart';
import 'package:movie_app/features/years_back/cubit/years_back_cubit.dart';
import 'package:movie_app/injection.dart';
import 'package:movie_app/theme/custom_theme.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieFlowCubit>(
            create: (BuildContext context) => serviceLocator<MovieFlowCubit>()),
        BlocProvider<YearsBackCubit>(
          create: (BuildContext context) => serviceLocator<YearsBackCubit>(),
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
      child: MaterialApp(
        title: 'Movie Recommendation',
        theme: CustomTheme.darkTheme(context),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const MovieFlow(),
          '/results': (context) => const ResultScreenAnimator(),
        },
      ),
    );
  }
}
