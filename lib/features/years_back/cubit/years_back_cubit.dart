import 'package:flutter_bloc/flutter_bloc.dart';

class YearsBackCubit extends Cubit<int> {
  YearsBackCubit() : super(10);

  void setYearsBack(int yearsBack) {
    emit(yearsBack);
  }
}
