import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
import '../../../utils/utils.dart';
import '../../../themes/themes.dart';
import '../../widgets/widgets.dart';
import '../../../data/models/models.dart';

class InfoPanel extends StatelessWidget {
  final double income;
  final double expenses;
  const InfoPanel({Key? key, required this.income, required this.expenses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: state.showInformationPanel ? 280 : 187,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      height: 85,
                      width: 100,
                      child: CustomPieChart(
                          sectors: _buildSectors(state.isTypeButton))),
                  _Informations(income: income, expenses: expenses),
                ],
              ),
              if (state.showInformationPanel)
                const SizedBox(
                  height: 32,
                ),
              Visibility(
                child: PanelLegends(legends: _buildLegends(state.isTypeButton)),
                visible: state.showInformationPanel,
              ),
              const _ChangeChartButton(),
              const AnimatedExpandIconButton()
            ],
          ),
        );
      },
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

class _ChangeChartButton extends StatelessWidget {
  const _ChangeChartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
      builder: (context, state) {
        final isCategory = state.isTypeButton;

        return Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(right: 18)),
              onPressed: () {
                context.read<AppInteractionCubit>().typeButtonPressed();
              },
              child: state.isTypeButton
                  ? const Text('Ver Classificação')
                  : const Text('Ver Tipo')),
        );
      },
    );
  }
}
