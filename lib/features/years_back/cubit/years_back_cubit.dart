import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class YearsBackCubit extends Cubit<int> {
  YearsBackCubit() : super(10);

  void setYearsBack(int yearsBack) {
    emit(yearsBack);
  }
}
