// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget(
      {super.key,
      required this.hintTextDropDownMenu,
      required this.dropdownItems,
      required this.onSelect,
      required this.dropdownFormKey});

  final String hintTextDropDownMenu;
  final List<DropdownMenuItem<String>> dropdownItems;
  final dropdownFormKey;
  final Function(String?) onSelect;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: dropdownFormKey,
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: hintTextDropDownMenu,
            labelStyle: const TextStyle(
                color: gray, fontWeight: FontWeight.w400, fontSize: 20),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: red2, width: 2)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: red2, width: 2),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: red2, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          validator: (value) =>
              value == null ? "Please select from the menu" : null,
          dropdownColor: white,
          onChanged: onSelect,
          iconEnabledColor: red2,
          items: dropdownItems),
    );
  }
}
