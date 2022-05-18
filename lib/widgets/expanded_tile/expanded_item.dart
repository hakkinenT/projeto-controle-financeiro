import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/themes/app_colors.dart';
import 'package:projeto_controle_financeiro/themes/app_typograph.dart';

class ExpandedItem extends StatelessWidget {
  final String description;
  final double value;
  const ExpandedItem({Key? key, required this.description, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            style: AppTypograph.smallTextBold
                .copyWith(color: AppColors.grayDarkColor),
          ),
          const Spacer(),
          Text('R\$ ${value.toStringAsFixed(2)}',
              style: AppTypograph.smallText
                  .copyWith(color: AppColors.grayDarkColor))
        ],
      ),
    );
  }
}
