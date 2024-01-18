import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';
import 'package:movie_app/features/genre/domain/usecases/genre_usecase.dart';

part 'genre_state.dart';

@Injectable()
class GenreCubit extends Cubit<GenreState> {
  GenreCubit({required this.genreUseCase})
      : super(const GenreInitial(genres: []));

  final GenreUseCase genreUseCase;
  Future<void> getGenres() async {
    emit(const GenreLoadingState(genres: []));
    final genres = await genreUseCase.getGenres();
    genres.fold((error) => emit(GenreErrorState(message: error.message)),
        (genres) => emit(GenreLoadedState(genres: genres)));
  }

  void toggleSelected(GenreEntity genre) {
    final genres = [
      for (final oldGenre in state.genres)
        if (oldGenre == genre) oldGenre.toggleSelected() else oldGenre
    ];
    emit(GenreLoadedState(genres: genres));
  }
}
