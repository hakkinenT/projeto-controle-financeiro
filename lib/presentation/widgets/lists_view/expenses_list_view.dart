import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/presentation/screens/screens.dart';

import '../../widgets/widgets.dart';
import '../../../data/models/models.dart';

class ExpensesListView extends StatelessWidget {
  final List<Expense> expenses;
  const ExpensesListView({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return ExpensesTile(
            expense: expenses[index],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ExpensePage(expense: expenses[index])));
            },
          );
        },
        itemCount: expenses.length);
  }
}
