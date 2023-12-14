import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

// ignore: must_be_immutable
class AuthButton extends StatelessWidget {
  AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    this.textColor = white,
  });
  final Function() onPressed;
  final String buttonText;
  final Color buttonColor;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(divide: 1.3),
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(textColor),
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
        onPressed: onPressed,
        child: TextWidget(text: buttonText, fontSizeText: 20),
      ),
    );
  }
}
