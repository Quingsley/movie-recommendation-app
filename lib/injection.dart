import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/genre/data/datasources/genre_data_source.dart';
import 'package:movie_app/features/genre/data/repositories/genre_repository_impl.dart';
import 'package:movie_app/features/genre/domain/repositories/igenre_repository.dart';
import 'package:movie_app/features/genre/domain/usecases/genre_usecase.dart';
import 'package:movie_app/features/genre/presentation/cubit/genre_cubit.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';
import 'package:movie_app/features/rating/cubit/rating_cubit.dart';
import 'package:movie_app/features/results/data/datasources/movie_data_source.dart';
import 'package:movie_app/features/results/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/features/results/domain/repositories/imovie_repository.dart';
import 'package:movie_app/features/results/domain/usecases/movie_usecase.dart';
import 'package:movie_app/features/results/presentation/cubit/results_cubit.dart';
import 'package:movie_app/features/years_back/cubit/years_back_cubit.dart';

final serviceLocator = GetIt.I;

Future<void> init() async {
  //---------------------genres---------------------------
  serviceLocator.registerFactory<GenreDataSource>(
      () => GenreDataSourceImpl(client: serviceLocator()));

  serviceLocator.registerFactory<IGenreRepository>(
      () => GenreRepositoryImpl(genreDataSource: serviceLocator()));

  serviceLocator.registerFactory<GenreUseCase>(
      () => GenreUseCase(genreRepository: serviceLocator()));

  serviceLocator.registerFactory<GenreCubit>(
      () => GenreCubit(genreUseCase: serviceLocator()));

  // --------------------------movie-----------------------
  serviceLocator.registerFactory<MovieDataSource>(
      () => MovieDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerFactory<IMovieRepository>(
      () => MovieRepository(movieDataSource: serviceLocator()));

  serviceLocator
      .registerFactory<MovieUseCase>(() => MovieUseCase(serviceLocator()));

  serviceLocator.registerFactory<ResultsCubit>(
      () => ResultsCubit(movieUseCase: serviceLocator()));

//---------------------------general------------------------
  serviceLocator.registerFactory<MovieFlowCubit>(() => MovieFlowCubit());
  serviceLocator.registerFactory<RatingCubit>(() => RatingCubit());
  serviceLocator.registerFactory<YearsBackCubit>(() => YearsBackCubit());

  serviceLocator.registerFactory(() => Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3',
          connectTimeout: const Duration(seconds: 10),
        ),
      ));
}
