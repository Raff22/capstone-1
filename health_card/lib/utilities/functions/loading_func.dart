import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator(color: red2));
      });
}
