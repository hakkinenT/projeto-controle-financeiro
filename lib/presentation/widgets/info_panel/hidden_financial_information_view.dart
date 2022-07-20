import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
import '../../../data/models/models.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class HiddenFinancialInformationView extends StatelessWidget {
  const HiddenFinancialInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _DynamicWhiteSpace(),
        _FinancialInformationChartLegends(),
      ],
    );
  }
}

class _DynamicWhiteSpace extends StatelessWidget {
  const _DynamicWhiteSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
      builder: (context, state) {
        if (state.showInformationPanel) {
          return const SizedBox(
            height: 32,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _FinancialInformationChartLegends extends StatelessWidget {
  const _FinancialInformationChartLegends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
        builder: (context, state) {
      return Visibility(
        child:
            PanelLegends(legends: _buildLegends(context, state.isTypeButton)),
        visible: state.showInformationPanel,
      );
    });
  }

  List<ChartLegend> _buildLegends(BuildContext context, bool isTypeButton) {
    final informationPanelState = context.watch<InformationPanelCubit>().state;
    final legends = <ChartLegend>[];
    if (informationPanelState is InformationPanelSuccess) {
      if (isTypeButton) {
        legends.add(ChartLegend(
            text: classificationEnumMap[Classification.essential]!,
            percentage: (informationPanelState.percentExpenseEssential / 100),
            value: informationPanelState.totalExpenseEssential,
            color: AppColors.chartEssentialColor));
        legends.add(ChartLegend(
            text: classificationEnumMap[Classification.nonEssential]!,
            percentage:
                (informationPanelState.percentExpenseNonEssential / 100),
            value: informationPanelState.totalExpenseNonEssential,
            color: AppColors.chartNonEssentialColor));
      } else {
        legends.add(ChartLegend(
            text: typeEnumMap[Type.fixed]!,
            percentage: (informationPanelState.percentExpenseFixed / 100),
            value: informationPanelState.totalExpenseFixed,
            color: AppColors.chartFixedColor));
        legends.add(ChartLegend(
            text: typeEnumMap[Type.nonFixed]!,
            percentage: (informationPanelState.percentExpenseNonFixed / 100),
            value: informationPanelState.totalExpenseNonFixed,
            color: AppColors.chartNonFixedColor));
      }
    }
    return legends;
  }
}
