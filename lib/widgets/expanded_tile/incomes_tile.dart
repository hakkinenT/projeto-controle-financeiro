import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class IncomesTile extends StatefulWidget {
  final Income income;
  const IncomesTile({Key? key, required this.income}) : super(key: key);

  @override
  State<IncomesTile> createState() => _IncomesTileState();
}

class _IncomesTileState extends State<IncomesTile> {
  late double _value;
  late String _type;

  late List<ExpandedItem> _items;

  @override
  void initState() {
    _value = widget.income.value;
    _type = typeEnumMap[widget.income.type]!;

    _items = [
      ExpandedItem(
          description: 'Valor', value: AppNumberFormat.getCurrency(_value)),
      ExpandedItem(description: 'Tipo', value: _type)
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpandedTile(
        prefixIcon: Icons.trending_up,
        title: widget.income.description,
        expandedItems: _items,
        onButtonPressed: () {});
  }
}
