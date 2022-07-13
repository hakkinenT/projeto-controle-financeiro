import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/business_logic/business_logic.dart';
import 'package:projeto_controle_financeiro/themes/app_colors.dart';

class AnimatedExpandIconButton extends StatelessWidget {
  const AnimatedExpandIconButton({Key? key}) : super(key: key);

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
