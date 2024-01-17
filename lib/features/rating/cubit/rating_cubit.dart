import 'package:flutter_bloc/flutter_bloc.dart';

class RatingCubit extends Cubit<int> {
  RatingCubit() : super(5);

  void setRating(int updatedRating) {
    emit(updatedRating);
  }
}
