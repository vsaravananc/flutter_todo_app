part of 'analystic_bloc.dart';

@immutable
sealed class AnalysticState extends Equatable {}

final class AnalysticInitial extends AnalysticState {
  @override
  List<Object?> get props => [];
}

final class AnalysticLoaded extends AnalysticState {
  final int completedTask;
  final int pendingTask;
  final PieChartModel pieChartModel;
  AnalysticLoaded({
    required this.completedTask,
    required this.pendingTask,
    required this.pieChartModel,
  });
  @override
  List<Object?> get props => [completedTask, pendingTask, pieChartModel];
}

final class AnalysticFailed extends AnalysticState {
  @override
  List<Object?> get props => [];
}
