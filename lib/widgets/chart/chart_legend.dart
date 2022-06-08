import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../themes/themes.dart';

class ChartLegend extends StatelessWidget {
  final String text;
  final double percentage;
  final double value;
  final Color color;

  const ChartLegend(
      {Key? key,
      required this.text,
      required this.percentage,
      required this.value,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: 300,
      child: Row(
        children: [
          Indicator(color: color, isSquare: true),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppTypograph.smallText,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            AppNumberFormat.getPercentage(percentage),
            style: AppTypograph.smallText.copyWith(color: Colors.black54),
          ),
          const Spacer(),
          Text(
            AppNumberFormat.getCurrency(value),
            textAlign: TextAlign.right,
            style: AppTypograph.smallText,
          )
        ],
      ),
    );
  }
}
