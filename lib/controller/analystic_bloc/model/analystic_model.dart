import 'package:equatable/equatable.dart';
import 'package:todoapp/features/analytics/model/pie_chart_model.dart';

class AnalysticModel extends Equatable {
  final int completedTask;
  final int pendingTask;
  final PieChartModel pieChartModel;

  const AnalysticModel({
    required this.completedTask,
    required this.pendingTask,
    required this.pieChartModel,
  });

  @override
  List<Object?> get props => [completedTask, pendingTask, pieChartModel];
}
