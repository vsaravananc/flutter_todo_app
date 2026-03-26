import 'package:equatable/equatable.dart';

class PieChartModel extends Equatable {
  final List<PieChartValueModel> listOfPieChartValue;
  const PieChartModel({required this.listOfPieChartValue});
  @override
  List<Object?> get props => listOfPieChartValue;
}


class PieChartValueModel extends Equatable {
  final String label;
  final int value;
  const PieChartValueModel({required this.label,required this.value});
  @override
  List<Object?> get props => [
    label,value
  ];

  factory PieChartValueModel.fromJson(Map<String,dynamic>json) {
    return PieChartValueModel(label: json['label'], value: json['value']);
  }

  Map<String,double> toJson(){
    return {
      label : double.parse("$value")
    };
  }
}