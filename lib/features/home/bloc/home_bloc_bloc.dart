import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';
import 'package:todoapp/features/home/data/model/category_model.dart';
import 'package:todoapp/features/home/domain/home_domain.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final HomeDomain selecteCategory;
  final HomeDomain loadCategory;
  final HomeDomain addCategory;
  HomeBloc( {required this.selecteCategory, required this.loadCategory,required this.addCategory})
    : super(InitialCategoryState()) {
    on<SelectCategoryEvent>(
      (event, emit) => selecteCategory.triggerEvent(event, emit, state),
    );
    on<LoadCategoryEvent>(
      (event, emit) => loadCategory.triggerEvent(event, emit, state),
    );
    on<AddCategoryEvent>((event, emit) => addCategory.triggerEvent(event, emit, state));
  }
}
