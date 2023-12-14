import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';

class RowWidget extends StatelessWidget {
  const RowWidget(
      {super.key, required this.text, this.onPressed, required this.icon});

  final String text;
  final Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: text,
          colorText: black,
          fontSizeText: 18,
          fontWeightText: FontWeight.w300,
        ),
        IconButton(onPressed: onPressed, icon: icon),
      ],
    );
  }
}
