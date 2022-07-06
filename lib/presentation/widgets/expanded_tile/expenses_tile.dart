import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../widgets/widgets.dart';
import '../../../utils/utils.dart';

class ExpensesTile extends StatefulWidget {
  final Expense expense;
  final Function() onPressed;
  const ExpensesTile({Key? key, required this.expense, required this.onPressed})
      : super(key: key);

  @override
  State<ExpensesTile> createState() => _ExpensesTileState();
}

class _ExpensesTileState extends State<ExpensesTile> {
  late final double _value;
  late final String _category;
  late final String _type;

  late List<ExpandedItem> items;

  @override
  void initState() {
    _value = widget.expense.value;
    _category = classificationEnumMap[widget.expense.classification]!;
    _type = typeEnumMap[widget.expense.type]!;

    items = [
      ExpandedItem(
          description: 'Total', value: AppNumberFormat.getCurrency(_value)),
      ExpandedItem(description: 'Categoria', value: _category),
      ExpandedItem(description: 'Tipo', value: _type)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpandedTile(
        prefixIcon: Icons.trending_down,
        title: widget.expense.description,
        expandedItems: items,
        onButtonPressed: widget.onPressed);
  }
}
