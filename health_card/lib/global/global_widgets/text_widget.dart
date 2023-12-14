import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.fontWeightText,
      this.colorText,
      this.fontSizeText,
      this.fontFamilyText});
  final String text;
  final FontWeight? fontWeightText;
  final Color? colorText;
  final double? fontSizeText;
  final String? fontFamilyText;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        
          fontWeight: fontWeightText,
          color: colorText,
          fontSize: fontSizeText,
          fontFamily: fontFamilyText),
    );
  }
}
