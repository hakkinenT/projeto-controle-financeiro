import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class PanelLegends extends StatelessWidget {
  final List<ChartLegend> legends;
  const PanelLegends({Key? key, required this.legends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: legends,
    );
  }
}
