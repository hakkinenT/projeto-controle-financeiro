import 'package:flutter/material.dart';

import '../../fake_data/fake_expenses.dart';
import '../../fake_data/fake_incomes.dart';

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
                      onPressed: () {}, icon: const Icon(Icons.account_circle)),
                ),
                const SizedBox(
                  height: 15,
                ),
                const InfoPanel(
                  income: 2000,
                  expenses: 1000,
                ),
                ShowSelectedPage(incomes: incomes, expenses: expenses)
              ],
            ),
          ),
        ),
        floatingActionButton:
            ExpandableFab(scrollController: scrollController, children: [
          ActionButton(
            icon: const Icon(Icons.trending_down),
            onPressed: () {
              print('Adicionar despesa');
            },
          ),
          ActionButton(
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
