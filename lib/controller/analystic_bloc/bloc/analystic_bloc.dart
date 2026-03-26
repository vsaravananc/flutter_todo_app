import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/controller/analystic_bloc/usecase/get_analystic.dart';
import 'package:todoapp/features/analytics/model/pie_chart_model.dart';

part 'analystic_event.dart';
part 'analystic_state.dart';

class AnalysticBloc extends Bloc<AnalysticEvent, AnalysticState> {
  final GetAnalysticRepo getAnalysticRepo;
  AnalysticBloc(this.getAnalysticRepo) : super(AnalysticInitial()) {
    on<AnalysticGetData>((event, emit) async {
      final result = await getAnalysticRepo.getanalysticdata();
     await result.fold(
        (success) async{
         final result =  await _sortIT(success.pieChartModel.listOfPieChartValue);
         debugPrint("result : ${result.listOfPieChartValue}");
          emit(
            AnalysticLoaded(
              completedTask: success.completedTask,
              pendingTask: success.pendingTask,
              pieChartModel: result,
            ),
          );
        },
        (failed) {
          emit(AnalysticFailed());
        },
      );
    });
  }

  Future<PieChartModel> _sortIT(List<PieChartValueModel> pieChartModel)async{
    final result = await compute(_sortOnCompute, pieChartModel);
    return PieChartModel(listOfPieChartValue: result);
  }
}

List<PieChartValueModel> _sortOnCompute(List<PieChartValueModel> pieChartModel){
  for(int i = 0;i < pieChartModel.length;i++){
    for(int j = i+1; j < pieChartModel.length ; j++ ){
      if(pieChartModel[i].value < pieChartModel[j].value){
        PieChartValueModel a = pieChartModel[i];
        pieChartModel[i]= pieChartModel[j];
        pieChartModel[j] = a;
      }
    }
  }
  if(pieChartModel.length > 6){
    return pieChartModel.sublist(0,6);
  }
  return pieChartModel;
}