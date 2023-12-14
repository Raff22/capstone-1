import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/views/intro_views/select_user_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.removeUnitl(const SelectUserScreen());
    });
    return Scaffold(
        backgroundColor: white,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/images/moseefy_logo.png'),
        )));
  }
}
