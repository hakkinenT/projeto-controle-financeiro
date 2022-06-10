import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../themes/themes.dart';
import '../../widgets/widgets.dart';
import '../../../data/models/models.dart';

class InfoPanel extends StatefulWidget {
  final double income;
  final double expenses;

  const InfoPanel({
    Key? key,
    required this.income,
    required this.expenses,
  }) : super(key: key);

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel> {
  bool panelVisible = false;
  bool isCategory = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: panelVisible ? 280 : 187,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height: 85,
                  width: 100,
                  child: CustomPieChart(sectors: _buildSectors(isCategory))),
              _Informations(income: widget.income, expenses: widget.expenses),
            ],
          ),
          if (panelVisible)
            const SizedBox(
              height: 32,
            ),
          Visibility(
            child: PanelLegends(legends: _buildLegends(isCategory)),
            visible: panelVisible,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(right: 18)),
                onPressed: () {
                  setState(() {
                    isCategory = !isCategory;
                  });
                },
                child: isCategory
                    ? const Text('Ver Tipo')
                    : const Text('Ver Classificação')),
          ),
          IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  panelVisible = !panelVisible;
                });
              },
              icon: panelVisible
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more))
        ],
      ),
    );
  }

  List<ChartSector> _buildSectors(bool isCategory) {
    final List<ChartSector> sectors;
    if (isCategory) {
      sectors = [
        ChartSector(color: AppColors.chartEssentialColor, value: 70),
        ChartSector(color: AppColors.chartNonEssentialColor, value: 30),
      ];
    } else {
      sectors = [
        ChartSector(color: AppColors.chartFixedColor, value: 70),
        ChartSector(color: AppColors.chartVariableColor, value: 30),
      ];
    }
    return sectors;
  }

  List<ChartLegend> _buildLegends(bool isCategory) {
    final List<ChartLegend> legends;
    if (isCategory) {
      legends = [
        ChartLegend(
            text: classificationEnumMap[Classification.essential]!,
            percentage: 0.7,
            value: 200,
            color: AppColors.chartEssentialColor),
        ChartLegend(
            text: classificationEnumMap[Classification.nonEssential]!,
            percentage: 0.3,
            value: 50,
            color: AppColors.chartNonEssentialColor),
      ];
    } else {
      legends = [
        ChartLegend(
            text: typeEnumMap[Type.fixed]!,
            percentage: 0.7,
            value: 200,
            color: AppColors.chartFixedColor),
        ChartLegend(
            text: typeEnumMap[Type.nonFixed]!,
            percentage: 0.3,
            value: 50,
            color: AppColors.chartVariableColor),
      ];
    }
    return legends;
  }
}

class _Informations extends StatelessWidget {
  final double income;
  final double expenses;
  const _Informations({Key? key, required this.income, required this.expenses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'RENDA ATUAL',
          style: AppTypograph.overline,
        ),
        Text(
          AppNumberFormat.getCurrency(income),
          style: AppTypograph.headline5.copyWith(
              color: AppColors.primaryDarkColor, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          '${AppNumberFormat.getCurrency(expenses)} em gastos',
          style: AppTypograph.smallText.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}
