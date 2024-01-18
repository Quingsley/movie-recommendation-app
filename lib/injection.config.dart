// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'dio_provider.dart' as _i17;
import 'features/genre/data/datasources/genre_data_source.dart' as _i4;
import 'features/genre/data/repositories/genre_repository_impl.dart' as _i6;
import 'features/genre/domain/repositories/igenre_repository.dart' as _i5;
import 'features/genre/domain/usecases/genre_usecase.dart' as _i11;
import 'features/genre/presentation/cubit/genre_cubit.dart' as _i16;
import 'features/movie_flow/presentation/cubit/movie_flow_cubit.dart' as _i8;
import 'features/rating/cubit/rating_cubit.dart' as _i9;
import 'features/results/data/datasources/movie_data_source.dart' as _i7;
import 'features/results/data/repositories/movie_repository_impl.dart' as _i13;
import 'features/results/domain/repositories/imovie_repository.dart' as _i12;
import 'features/results/domain/usecases/movie_usecase.dart' as _i14;
import 'features/results/presentation/cubit/results_cubit.dart' as _i15;
import 'features/years_back/cubit/years_back_cubit.dart' as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioProvider = _$DioProvider();
  gh.singleton<_i3.Dio>(dioProvider.dio());
  gh.factory<_i4.GenreDataSource>(
      () => _i4.GenreDataSourceImpl(client: gh<_i3.Dio>()));
  gh.factory<_i5.IGenreRepository>(() =>
      _i6.GenreRepositoryImpl(genreDataSource: gh<_i4.GenreDataSource>()));
  gh.factory<_i7.MovieDataSource>(
      () => _i7.MovieDataSourceImpl(client: gh<_i3.Dio>()));
  gh.factory<_i8.MovieFlowCubit>(() => _i8.MovieFlowCubit());
  gh.factory<_i9.RatingCubit>(() => _i9.RatingCubit());
  gh.factory<_i10.YearsBackCubit>(() => _i10.YearsBackCubit());
  gh.factory<_i11.GenreUseCase>(
      () => _i11.GenreUseCase(genreRepository: gh<_i5.IGenreRepository>()));
  gh.factory<_i12.IMovieRepository>(
      () => _i13.MovieRepository(movieDataSource: gh<_i7.MovieDataSource>()));
  gh.factory<_i14.MovieUseCase>(
      () => _i14.MovieUseCase(gh<_i12.IMovieRepository>()));
  gh.factory<_i15.ResultsCubit>(
      () => _i15.ResultsCubit(movieUseCase: gh<_i14.MovieUseCase>()));
  gh.factory<_i16.GenreCubit>(
      () => _i16.GenreCubit(genreUseCase: gh<_i11.GenreUseCase>()));
  return getIt;
}

class _$DioProvider extends _i17.DioProvider {}
