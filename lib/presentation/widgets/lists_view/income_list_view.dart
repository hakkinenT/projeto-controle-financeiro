import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/presentation/screens/income_page/income_page.dart';

import '../../../data/models/models.dart';
import '../widgets.dart';

class IncomeListView extends StatelessWidget {
  final List<Income> incomes;

  const IncomeListView({
    Key? key,
    required this.incomes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return IncomesTile(
            income: incomes[index],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IncomePage(
                            income: incomes[index],
                            isDetailsPage: true,
                          )));
            },
          );
        },
        itemCount: incomes.length);
  }
}
