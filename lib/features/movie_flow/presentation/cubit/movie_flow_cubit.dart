import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/genre/presentation/cubit/genre_cubit.dart';

part 'movie_flow_state.dart';

class MovieFlowCubit extends Cubit<MovieFlowState> {
  MovieFlowCubit() : super(MovieFlowInitial(PageController()));

  void nextPage({BuildContext? context}) {
    debugPrint('page: ${state.controller.page}');
    if (state.controller.page! >= 1) {
      if (context != null) {
        // check if genre list is empty and return
        if (context.read<GenreCubit>().state.genres.isEmpty) return;
      }
    }
    state.controller.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    state.controller.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
