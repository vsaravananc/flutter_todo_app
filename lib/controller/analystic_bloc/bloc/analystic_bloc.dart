import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/controller/analystic_bloc/usecase/get_analystic.dart';
import 'package:todoapp/features/analytics/model/pie_chart_model.dart';

part 'analystic_event.dart';
part 'analystic_state.dart';

class AnalysticBloc extends Bloc<AnalysticEvent, AnalysticState> {
  final GetAnalysticRepo getAnalysticRepo;
  AnalysticBloc(this.getAnalysticRepo) : super(AnalysticInitial()) {
    on<AnalysticGetData>((event, emit) async {
      final result = await getAnalysticRepo.getanalysticdata();
      result.fold(
        (success) {
          debugPrint(
            "\u001B[32m completed : ${success.completedTask} \u001B[0m",
          );
          debugPrint(
            "\u001B[32m Pending : ${success.pendingTask} \u001B[0m",
          );

          debugPrint(
            "\u001B[32m PieChartModel : ${success.pieChartModel.listOfPieChartValue.length} \u001B[0m",
          );

          emit(
            AnalysticLoaded(
              completedTask: success.completedTask,
              pendingTask: success.pendingTask,
              pieChartModel: success.pieChartModel,
            ),
          );
        },
        (failed) {
          emit(AnalysticFailed());
        },
      );
    });
  }
}
