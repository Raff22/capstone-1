import 'package:flutter/material.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({
    super.key,
    required this.rowTitle,
    required this.icon,
    this.onPressd,
    this.convertIcon,
    this.onTap,
  });

  final String rowTitle;
  final IconData icon;
  final IconData? convertIcon;
  final Function()? onPressd;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressd,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              width12,
              TextWidget(
                text: rowTitle,
                fontSizeText: 17,
              ),
            ],
          ),
          Row(
            children: [IconButton(onPressed: onTap, icon: Icon(convertIcon))],
          )
        ],
      ),
    );
  }
}
