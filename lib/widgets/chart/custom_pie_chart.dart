import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../../models/models.dart';

class CustomPieChart extends StatelessWidget {
  final List<ChartSector> sectors;
  const CustomPieChart({Key? key, required this.sectors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
          color: AppColors.secondaryColor,
          child: PieChart(PieChartData(
              sectionsSpace: 0,
              sections: showingSections(sectors),
              centerSpaceRadius: 35.0))),
    );
  }

  List<PieChartSectionData> showingSections(List<ChartSector> sectors) {
    final List<PieChartSectionData> list = [];

    for (var sector in sectors) {
      const double radius = 25;
      final data = PieChartSectionData(
          color: sector.color, value: sector.value, radius: radius, title: '');
      list.add(data);
    }
    return list;
  }
}
