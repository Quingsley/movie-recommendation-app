import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RatingCubit extends Cubit<int> {
  RatingCubit() : super(5);

  void setRating(int updatedRating) {
    emit(updatedRating);
  }
}
