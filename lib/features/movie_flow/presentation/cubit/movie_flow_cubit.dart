import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/genre/presentation/cubit/genre_cubit.dart';

class MovieFlowCubit extends Cubit<PageController> {
  MovieFlowCubit() : super(PageController());

  void nextPage({BuildContext? context}) {
    debugPrint('current page: ${state.page}');
    final nextPage = state.page! + 1;
    debugPrint('next page: $nextPage');
    if (state.page == 1) {
      if (context != null) {
        // check if any genre is selected and if none return
        final condition = context
            .read<GenreCubit>()
            .state
            .genres
            .any((genre) => genre.isSelected);
        if (!condition) return;
      }
    }

    state.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    state.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }
}
