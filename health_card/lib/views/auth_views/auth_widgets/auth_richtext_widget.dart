import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';

class AuthRichText extends StatelessWidget {
  const AuthRichText({
    super.key,
    required this.text1,
    required this.text2,
    required this.screen,
  });
  final String text1;
  final String text2;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: text1,
            style: const TextStyle(
                fontSize: 16,
                letterSpacing: 1,
                // fontWeight: FontWeight.bold,
                color: Colors.black)),
        TextSpan(
          text: text2,
          recognizer: TapGestureRecognizer()
            ..onTap = () => context.removeUnitl(screen),
          style: const TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1,
              color: Color.fromARGB(255, 186, 32, 32)),
        )
      ])),
    );
  }
}
