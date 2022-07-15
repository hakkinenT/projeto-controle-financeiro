import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
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
    scrollController.addListener(listen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(listen);
    scrollController.dispose();

    super.dispose();
  }

  void listen() {
    final direction = scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      context.read<AppInteractionCubit>().showWidgetOnScroll();
    } else if (direction == ScrollDirection.reverse) {
      context.read<AppInteractionCubit>().hideWidgetOnScroll();
    }
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
        floatingActionButton: const _HideFabButton(),
        bottomNavigationBar: const _HideBottonNavigatorBar());
  }
}

class _HideFabButton extends StatelessWidget {
  const _HideFabButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
        builder: (context, state) {
      if (state.isPageScroll) {
        return const FabMenuButton();
      } else {
        return const SizedBox();
      }
    });
  }
}

class _HideBottonNavigatorBar extends StatelessWidget {
  final Duration duration;
  const _HideBottonNavigatorBar(
      {Key? key, this.duration = const Duration(milliseconds: 200)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: duration,
        height: state.isPageScroll ? kBottomNavigationBarHeight : 0,
        child: Wrap(children: [
          BottomNavigationBar(currentIndex: 0, items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Histórico')
          ])
        ]),
      );
    });
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
  final PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IncomeFilterChip(pageController: pageController),
                _ExpenseFilterChip(pageController: pageController)
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            _InformationPageView(pageController: pageController)
          ],
        );
      },
    );
  }
}

class _InformationPageView extends StatelessWidget {
  final PageController pageController;
  const _InformationPageView({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        pageSnapping: true,
        controller: pageController,
        onPageChanged: (index) =>
            context.read<AppInteractionCubit>().pageFilterChipChanged(index),
        itemCount: 2,
        itemBuilder: (context, pagePosition) {
          return _pages(pagePosition);
        },
      ),
    );
  }

  Widget _pages(int index) {
    final listPages = [
      const _PageIncome(),
      const _PageExpense(),
    ];
    return listPages[index];
  }
}

class _IncomeFilterChip extends StatelessWidget {
  final PageController pageController;
  const _IncomeFilterChip({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appInteractionCubit = context.read<AppInteractionCubit>();

    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
        builder: (context, state) {
      return CustomFilterChip(
          label: 'Rendas',
          selected: state.isIncomeFilterSelected,
          avatar: const Icon(
            Icons.trending_up,
            size: 25,
          ),
          onSelected: (bool selected) {
            appInteractionCubit.incomeFilterChipSelected(selected);
            int pageIndex = appInteractionCubit.pageIndex;
            pageController.animateToPage(pageIndex,
                duration: const Duration(milliseconds: 250),
                curve: Curves.bounceInOut);
          });
    });
  }
}

class _ExpenseFilterChip extends StatelessWidget {
  final PageController pageController;
  const _ExpenseFilterChip({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appInteractionCubit = context.read<AppInteractionCubit>();

    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
      builder: (context, state) {
        return CustomFilterChip(
            label: 'Despesas',
            selected: state.isExpenseFilterSelected,
            avatar: const Icon(
              Icons.trending_down,
              size: 25,
            ),
            onSelected: (bool selected) {
              appInteractionCubit.expenseFilterChipSelected(selected);
              int pageIndex = appInteractionCubit.pageIndex;
              pageController.animateToPage(pageIndex,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.bounceInOut);
            });
      },
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
