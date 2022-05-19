import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_controle_financeiro/themes/app_colors.dart';
import 'package:projeto_controle_financeiro/widgets/expanded_tile/expanded_item.dart';

class CustomExpandedTile extends StatefulWidget {
  final String title;
  final List<ExpandedItem> expandedItems;
  final Widget? subtitle;
  final IconData? prefixIcon;
  final Function()? onButtonPressed;

  const CustomExpandedTile(
      {Key? key,
      required this.title,
      this.subtitle,
      this.prefixIcon,
      required this.expandedItems,
      required this.onButtonPressed})
      : super(key: key);

  @override
  State<CustomExpandedTile> createState() => _CustomExpandedTileState();
}

class _CustomExpandedTileState extends State<CustomExpandedTile> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.title,
        style: TextStyle(color: _itemColor(_customTileExpanded)),
      ),
      subtitle: widget.subtitle,
      childrenPadding: const EdgeInsets.all(16),
      leading: Icon(widget.prefixIcon, color: _itemColor(_customTileExpanded)),
      trailing: Icon(Icons.expand_more, color: _itemColor(_customTileExpanded)),
      children: [
        for (var item in widget.expandedItems) item,
        TextButton(
            onPressed: widget.onButtonPressed,
            child: Text(
              'Ver mais',
              style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(fontSize: 14)),
            ))
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }

  Color _itemColor(bool customTileExpanded) {
    if (customTileExpanded) {
      return AppColors.primaryDarkColor;
    } else {
      return AppColors.textColor;
    }
  }
}
