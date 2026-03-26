import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todoapp/controller/analystic_bloc/bloc/analystic_bloc.dart';

class PiChartWidget extends StatelessWidget {
  const PiChartWidget({super.key});

  static final List<Color> _colorList = [
    const Color.fromRGBO(13, 71, 161, 1),
    const Color.fromRGBO(64, 159, 241, 1),
    const Color.fromRGBO(100, 181, 246, 1),
    const Color.fromRGBO(169, 218, 235, 1),
    const Color.fromRGBO(193, 231, 244, 1),
    const Color.fromRGBO(214, 239, 248, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<AnalysticBloc, AnalysticState>(
        builder: (context, state) {
          if (state is! AnalysticLoaded) return const SizedBox.shrink();
          Map<String, double> dataMap = {};
          for (var element in state.pieChartModel.listOfPieChartValue) {
            dataMap.addAll(element.toJson());
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 110,
                width: 110,
                child: FittedBox(
                  child: PieChart(
                    chartRadius: 110,
                    colorList: _colorList,
                    dataMap: dataMap,
                    legendOptions: const LegendOptions(showLegends: false),
                    ringStrokeWidth: 35,

                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                    chartType: ChartType.ring,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.pieChartModel.listOfPieChartValue.map((e) {
                  final color =
                      _colorList[state.pieChartModel.listOfPieChartValue
                          .indexOf(e)];
                  return Row(
                    spacing: 4,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                      Text(e.label),
                    ],
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}