import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
import '../../../themes/themes.dart';
import 'hidden_financial_information_view.dart';
import 'principal_financial_information_view.dart';

class FinancialInformationPanel extends StatelessWidget {
  const FinancialInformationPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<InformationPanelCubit>(context)
        ..informationPanelCalculated(),
      child: const FinancialInformationPanelView(),
    );
  }
}

class FinancialInformationPanelView extends StatelessWidget {
  const FinancialInformationPanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      PrincipalFinancialInformationView(),
      HiddenFinancialInformationView(),
      _AnimatedExpandIconButton()
    ]);
  }
}

class _AnimatedExpandIconButton extends StatelessWidget {
  const _AnimatedExpandIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
      builder: (context, state) {
        return ExpandIcon(
            color: AppColors.textColor,
            padding: EdgeInsets.zero,
            size: 30,
            isExpanded: state.showInformationPanel,
            onPressed: (bool isExpanded) {
              context
                  .read<AppInteractionCubit>()
                  .expandIconButtonPressed(isExpanded);
            });
      },
    );
  }
}
