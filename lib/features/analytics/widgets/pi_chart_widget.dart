import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PiChartWidget extends StatelessWidget {
  const PiChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          height: 110,
          width: 110,
          child: FittedBox(
            child: PieChart(
              chartRadius: 110,
              colorList: const [
                Color.fromRGBO(13, 71, 161, 1),
                Color.fromRGBO(64, 159, 241, 1),
                Color.fromRGBO(100, 181, 246, 1),
                Color.fromRGBO(173, 216, 230, 1),
                Color.fromRGBO(193, 231, 244, 1),
              ],
              dataMap: const {
                "dataMap": 28,
                "mmmm": 1,
                "cc": 1,
                "mmmfm": 1,
                "cxc": 1,
              },
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
          children: [ Row(
              spacing: 4,
              children: [
                Container(height: 10, width: 10, color: Colors.blue),
                Text("All"),
              ],
            ),
            Row(
              spacing: 4,
              children: [
                Container(height: 10, width: 10, color: Colors.blue),
                Text("Work"),
              ],
            ),
            Row(
              spacing: 4,
              children: [
                Container(height: 10, width: 10, color: Colors.blue),
                Text("Personal"),
              ],
            ),
            Row(
              spacing: 4,
              children: [
                Container(height: 10, width: 10, color: Colors.blue),
                Text("Shopping"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
