import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../../../data/models/models.dart';

class ShowSelectedPage extends StatefulWidget {
  final List<Income> incomes;
  final List<Expense> expenses;

  const ShowSelectedPage(
      {Key? key, required this.incomes, required this.expenses})
      : super(key: key);

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
            children: [
              IncomeListView(incomes: widget.incomes),
              ExpensesListView(expenses: widget.expenses),
            ],
          ),
        )
      ],
    );
  }
}
