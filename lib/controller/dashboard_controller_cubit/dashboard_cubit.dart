import 'package:bloc/bloc.dart';


class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);
  void setCurrentIndex(int index){
    emit(index);
  }
}
