import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
import '../../../data/models/models.dart';

import '../../widgets/widgets.dart';
import '../../../utils/utils.dart';

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
                const InformationPage()
              ],
            ),
          ),
        ),
        floatingActionButton:
            ExpandableFab(scrollController: scrollController, children: [
          ActionButton(
            heroTag: 'fBtnExpense',
            icon: const Icon(Icons.trending_down),
            onPressed: () {
              Navigator.pushNamed(context, kRegisterExpensesPath);
            },
          ),
          ActionButton(
            heroTag: 'fBtnIncome',
            icon: const Icon(Icons.trending_up),
            onPressed: () {
              Navigator.pushNamed(context, kRegisterIncomePath);
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

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<IncomeCubit>(context)..getAllIncomes(),
        ),
        BlocProvider.value(
            value: BlocProvider.of<ExpenseCubit>(context)..getAllExpenses()),
      ],
      child: const ShowSelectedPage(),
    );
  }
}

class ShowSelectedPage extends StatefulWidget {
  const ShowSelectedPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowSelectedPage> createState() => _ShowSelectedPageState();
}

class _ShowSelectedPageState extends State<ShowSelectedPage> {
  bool _isIncomeSelected = true;
  bool _isExpensesSelected = false;
  final PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterChip(
                label: const Text(
                  'Rendas',
                ),
                selected: _isIncomeSelected,
                showCheckmark: false,
                avatar: const Icon(
                  Icons.trending_up,
                  size: 25,
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                labelPadding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                onSelected: (bool selected) {
                  setState(() {
                    _isIncomeSelected = selected;

                    if (_isIncomeSelected) {
                      _isExpensesSelected = false;
                      pageController.animateToPage(--pageChanged,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.bounceInOut);
                    } else if (_isIncomeSelected == false &&
                        _isExpensesSelected == false) {
                      _isIncomeSelected = true;
                    }
                  });
                }),
            FilterChip(
                label: const Text(
                  'Despesas',
                ),
                selected: _isExpensesSelected,
                showCheckmark: false,
                padding: const EdgeInsets.only(left: 10, right: 10),
                avatar: const Icon(
                  Icons.trending_down,
                  size: 25,
                ),
                labelPadding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                onSelected: (bool selected) {
                  setState(() {
                    _isExpensesSelected = selected;

                    if (_isExpensesSelected) {
                      _isIncomeSelected = false;
                      pageController.animateToPage(++pageChanged,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.bounceInOut);
                    } else if (_isExpensesSelected == false &&
                        _isIncomeSelected == false) {
                      _isExpensesSelected = true;
                    }
                  });
                })
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 270,
          child: PageView(
            pageSnapping: true,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageChanged = index;
                if (pageChanged == 0) {
                  _isIncomeSelected = true;
                  _isExpensesSelected = false;
                } else {
                  _isExpensesSelected = true;
                  _isIncomeSelected = false;
                }
              });
            },
            children: const [
              _PageIncome(),
              _PageExpense(),
            ],
          ),
        )
      ],
    );
  }
}

class _PageIncome extends StatelessWidget {
  const _PageIncome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<IncomeCubit>().state;

    if (state is IncomeInitial) {
      return const SizedBox();
    } else if (state is IncomeLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is IncomeLoaded) {
      if (state.incomes.isEmpty) {
        return const Center(
          child: Text('Não há rendas cadastradas'),
        );
      } else {
        return IncomeListView(
          incomes: state.incomes,
        );
      }
    } else {
      return const Center(
        child: Text('Houve um erro ao tentar carregar as Rendas'),
      );
    }
  }
}

class _PageExpense extends StatelessWidget {
  const _PageExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExpenseCubit>().state;
    if (state is ExpenseInitial) {
      return const SizedBox();
    } else if (state is ExpenseLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ExpenseLoaded) {
      if (state.expenses.isEmpty) {
        return const Center(
          child: Text('Não há despesas cadastradas'),
        );
      } else {
        return ExpensesListView(
          expenses: state.expenses,
        );
      }
    } else {
      return const Center(
        child: Text('Houve um erro ao tentar carregar as Despesas'),
      );
    }
  }
}
