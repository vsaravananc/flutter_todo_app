import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';
import 'package:todoapp/features/home/data/model/category_model.dart';
import 'package:todoapp/features/home/domain/home_domain.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final HomeDomain selecteCategory;
  final HomeDomain loadCategory;
  HomeBlocBloc({required this.selecteCategory, required this.loadCategory})
    : super(InitialCategoryState()) {
    on<SelectCategoryEvent>((event, emit) => selecteCategory.triggerEvent(event,emit,state));
    on<LoadCategoryEvent>((event, emit) => loadCategory.triggerEvent(event,emit,state));
  }
}
