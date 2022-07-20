import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
import '../../../data/models/models.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class PrincipalFinancialInformationView extends StatelessWidget {
  const PrincipalFinancialInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformationPanelCubit, InformationPanelState>(
      builder: (context, state) {
        if (state is InformationPanelSuccess) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: 100,
                    child: _FinancialInformationChart(
                      percentExpenseEssential: state.percentExpenseEssential,
                      percentExpenseNonEssential:
                          state.percentExpenseNonEssential,
                      percentExpenseFixed: state.percentExpenseFixed,
                      percentExpenseNonFixed: state.percentExpenseNonFixed,
                      totalExpense: state.totalExpense,
                    )),
                _FinancialInformation(
                  currentIncome: state.currentIncome,
                  totalExpense: state.totalExpense,
                  totalIncome: state.totalIncome,
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _FinancialInformationItem extends StatelessWidget {
  final String legend;
  final double value;
  final TextStyle style;
  const _FinancialInformationItem(
      {Key? key,
      required this.legend,
      required this.value,
      required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          legend,
          style: AppTypograph.overline,
        ),
        Text(
          AppNumberFormat.getCurrency(value),
          style: style,
        ),
      ],
    );
  }
}

class _FinancialInformation extends StatelessWidget {
  final double currentIncome;
  final double totalIncome;
  final double totalExpense;
  const _FinancialInformation(
      {Key? key,
      required this.currentIncome,
      required this.totalIncome,
      required this.totalExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _FinancialInformationItem(
            legend: 'RENDA ATUAL',
            value: currentIncome,
            style: AppTypograph.headline5.copyWith(
                color: AppColors.currentIncomeColor,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        BlocBuilder<AppInteractionCubit, AppInteractionState>(
          builder: (context, state) {
            return _FinancialInformationItem(
                legend: 'DESPESA TOTAL',
                value: totalExpense,
                style: AppTypograph.headline6.copyWith(
                    color: state.isTypeButton
                        ? AppColors.chartEssentialColor
                        : AppColors.chartFixedColor));
          },
        ),
        const SizedBox(height: 6),
        _FinancialInformationItem(
            legend: 'RENDA TOTAL',
            value: totalIncome,
            style: AppTypograph.headline6
                .copyWith(color: AppColors.primaryDarkColor)),
      ],
    );
  }
}

class _FinancialInformationChart extends StatelessWidget {
  final double percentExpenseEssential;
  final double percentExpenseNonEssential;
  final double percentExpenseFixed;
  final double percentExpenseNonFixed;
  final double totalExpense;

  const _FinancialInformationChart(
      {Key? key,
      required this.percentExpenseEssential,
      required this.percentExpenseNonEssential,
      required this.percentExpenseFixed,
      required this.percentExpenseNonFixed,
      required this.totalExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
        builder: (context, state) {
      return CustomPieChart(sectors: _buildSectors(state.isTypeButton));
    });
  }

  List<ChartSector> _buildSectors(bool isTypeButton) {
    final sectors = <ChartSector>[];

    if (totalExpense == 0) {
      return sectors;
    }

    if (isTypeButton) {
      sectors.add(ChartSector(
          color: AppColors.chartEssentialColor,
          value: percentExpenseEssential));
      sectors.add(ChartSector(
          color: AppColors.chartNonEssentialColor,
          value: percentExpenseNonEssential));
    } else {
      sectors.add(ChartSector(
          color: AppColors.chartFixedColor, value: percentExpenseFixed));
      sectors.add(ChartSector(
          color: AppColors.chartNonFixedColor, value: percentExpenseNonFixed));
    }

    return sectors;
  }
}
