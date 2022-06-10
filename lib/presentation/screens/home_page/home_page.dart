import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
import '../../../data/models/models.dart';

import '../../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              controller: scrollController,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        context.read<AppBloc>().add(AppLogoutRequested());
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.account_circle)),
                ),
                const SizedBox(
                  height: 15,
                ),
                const InfoPanel(
                  income: 2000,
                  expenses: 1000,
                ),
                ShowSelectedPage(incomes: <Income>[
                  Income(
                      description: 'Salário',
                      value: 3500,
                      type: Type.fixed,
                      user: user)
                ], expenses: <Expense>[
                  Expense(
                      description: 'Conta de água',
                      value: 100,
                      classification: Classification.essential,
                      type: Type.fixed,
                      user: user,
                      expirationDate: DateTime.now())
                ])
              ],
            ),
          ),
        ),
        floatingActionButton:
            ExpandableFab(scrollController: scrollController, children: [
          ActionButton(
            heroTag: 'second',
            icon: const Icon(Icons.trending_down),
            onPressed: () {
              print('Adicionar despesa');
            },
          ),
          ActionButton(
            heroTag: 'third',
            icon: const Icon(Icons.trending_up),
            onPressed: () {
              print('Adicionar renda');
            },
          ),
        ]),
        bottomNavigationBar: ScrollToHideWidget(
          controller: scrollController,
          child: BottomNavigationBar(currentIndex: 0, items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Histórico')
          ]),
        ));
  }
}
