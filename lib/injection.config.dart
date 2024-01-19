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

import 'core/api/api_client.dart' as _i11;
import 'dio_provider.dart' as _i18;
import 'features/genre/data/datasources/genre_data_source.dart' as _i4;
import 'features/genre/data/repositories/genre_repository_impl.dart' as _i6;
import 'features/genre/domain/repositories/igenre_repository.dart' as _i5;
import 'features/genre/domain/usecases/genre_usecase.dart' as _i12;
import 'features/genre/presentation/cubit/genre_cubit.dart' as _i17;
import 'features/movie_flow/presentation/cubit/movie_flow_cubit.dart' as _i8;
import 'features/rating/cubit/rating_cubit.dart' as _i9;
import 'features/results/data/datasources/movie_data_source.dart' as _i7;
import 'features/results/data/repositories/movie_repository_impl.dart' as _i14;
import 'features/results/domain/repositories/imovie_repository.dart' as _i13;
import 'features/results/domain/usecases/movie_usecase.dart' as _i15;
import 'features/results/presentation/cubit/results_cubit.dart' as _i16;
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
      () => _i4.GenreDataSourceImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i5.IGenreRepository>(() =>
      _i6.GenreRepositoryImpl(genreDataSource: gh<_i4.GenreDataSource>()));
  gh.factory<_i7.MovieDataSource>(
      () => _i7.MovieDataSourceImpl(dio: gh<_i3.Dio>()));
  gh.factory<_i8.MovieFlowCubit>(() => _i8.MovieFlowCubit());
  gh.factory<_i9.RatingCubit>(() => _i9.RatingCubit());
  gh.factory<_i10.YearsBackCubit>(() => _i10.YearsBackCubit());
  gh.factory<_i11.ApiClient>(() => _i11.ApiClient(
        gh<_i3.Dio>(),
        baseUrl: gh<String>(),
      ));
  gh.factory<_i12.GenreUseCase>(
      () => _i12.GenreUseCase(genreRepository: gh<_i5.IGenreRepository>()));
  gh.factory<_i13.IMovieRepository>(
      () => _i14.MovieRepository(movieDataSource: gh<_i7.MovieDataSource>()));
  gh.factory<_i15.MovieUseCase>(
      () => _i15.MovieUseCase(gh<_i13.IMovieRepository>()));
  gh.factory<_i16.ResultsCubit>(
      () => _i16.ResultsCubit(movieUseCase: gh<_i15.MovieUseCase>()));
  gh.factory<_i17.GenreCubit>(
      () => _i17.GenreCubit(genreUseCase: gh<_i12.GenreUseCase>()));
  return getIt;
}

class _$DioProvider extends _i18.DioProvider {}
