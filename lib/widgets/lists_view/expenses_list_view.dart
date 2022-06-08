import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../../models/models.dart';

class ExpensesListView extends StatelessWidget {
  final List<Expenses> expenses;
  const ExpensesListView({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return ExpensesTile(expense: expenses[index]);
        },
        itemCount: expenses.length);
  }
}
