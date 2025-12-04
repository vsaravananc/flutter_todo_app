import 'package:bloc/bloc.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/category_controller/domain/home_domain.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final HomeDomain selecteCategory;
  final HomeDomain loadCategory;
  final HomeDomain addCategory;
  final HomeDomain deletedCategory;
  final HomeDomain editCategory;
  HomeBloc({
    required this.selecteCategory,
    required this.loadCategory,
    required this.addCategory,
    required this.deletedCategory,
    required this.editCategory,
  }) : super(InitialCategoryState()) {
    on<SelectCategoryEvent>((event, emit) async {
      await selecteCategory.triggerEvent(event, emit, state);
    });

    on<LoadCategoryEvent>((event, emit) async {
      await loadCategory.triggerEvent(event, emit, state);
    });

    on<AddCategoryEvent>((event, emit) async {
      await addCategory.triggerEvent(event, emit, state);
    });

    on<UpdateCategoryEvent>((event, emit) async {
      await editCategory.triggerEvent(event, emit, state);
    });

    on<DeleteCategoryEvent>((event, emit) async {
      await deletedCategory.triggerEvent(event, emit, state);
    });
  }
}
