import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:license_entrance/app/theme.dart';

class UserStatisticsGraph extends StatelessWidget {
  final List<dynamic> results;

  const UserStatisticsGraph({Key? key, required this.results})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(child: Text("No statistics available"));
    }

    List<FlSpot> spots =
        results.map((result) {
          final timestamp =
              DateTime.parse(
                result['timestamp'],
              ).millisecondsSinceEpoch.toDouble();

          final score =
              double.tryParse(result['score_percentage'].toString()) ?? 0.0;
          return FlSpot(timestamp, score);
        }).toList();
    spots.sort((a, b) => a.x.compareTo(b.x));

    double minX = spots.first.x;
    double maxX = spots.last.x;

    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: 0,
          maxY: 100,
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (maxX - minX) / 5,
                getTitlesWidget: (value, meta) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                    value.toInt(),
                  );

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "${date.month}/${date.day}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: CustomTheme.primaryText,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  return Text(
                    "${value.toInt()}%",
                    style: const TextStyle(
                      fontSize: 10,
                      color: CustomTheme.primaryText,
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
