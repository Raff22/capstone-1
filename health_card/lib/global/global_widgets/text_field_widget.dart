// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key, required this.controller, required this.labelText});

  TextEditingController controller = TextEditingController();
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
          color: black, fontWeight: FontWeight.w500, fontSize: 22),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 30, bottom: 30, right: 20),
        labelText: labelText,
        labelStyle: const TextStyle(
            color: gray, fontWeight: FontWeight.w400, fontSize: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: red2, width: 2)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: red2, width: 2),
        ),
      ),
    );
  }
}
