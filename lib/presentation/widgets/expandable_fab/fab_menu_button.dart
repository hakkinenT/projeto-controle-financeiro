import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/business_logic/business_logic.dart';

import '../widgets.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';

class FabMenuButton extends StatefulWidget {
  const FabMenuButton({Key? key}) : super(key: key);

  @override
  State<FabMenuButton> createState() => _FabMenuButtonState();
}

class _FabMenuButtonState extends State<FabMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  toggleMenu(BuildContext context) {
    final appInteractionCubit = context.read<AppInteractionCubit>();
    final state = appInteractionCubit.state;
    state.isFabMenuOpen ? animation.reverse() : animation.forward();
    appInteractionCubit.toggleFabMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
        clipBehavior: Clip.none,
        delegate: FabVerticalDelegate(
          animation: animation,
        ),
        children: [
          //É O BOTÃO QUE SEMPRE SERÁ MOSTRADO
          FloatingActionButton(
            heroTag: 'btnMenu',
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: animation,
            ),
            onPressed: () => toggleMenu(context),
          ),
          FloatingActionButton(
            backgroundColor: AppColors.primaryLightColor,
            heroTag: 'btnExpense',
            child: const Icon(Icons.trending_down),
            onPressed: () {
              toggleMenu(context);
              Navigator.pushNamed(context, kRegisterExpensesPath);
            },
          ),
          FloatingActionButton(
            backgroundColor: AppColors.primaryLightColor,
            heroTag: 'btnIncome',
            onPressed: () {
              toggleMenu(context);
              Navigator.pushNamed(context, kRegisterIncomePath);
            },
            child: const Icon(Icons.trending_up),
          ),
        ]);
  }
}
