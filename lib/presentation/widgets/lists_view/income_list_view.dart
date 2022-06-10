import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../widgets.dart';

class IncomeListView extends StatelessWidget {
  final List<Income> incomes;
  const IncomeListView({Key? key, required this.incomes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return IncomesTile(income: incomes[index]);
        },
        itemCount: incomes.length);
  }
}
