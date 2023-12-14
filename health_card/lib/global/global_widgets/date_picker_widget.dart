// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';

class DatePickerWidget extends StatelessWidget {
  DatePickerWidget(
      {super.key, required this.dateController, required this.labelText});

  TextEditingController dateController = TextEditingController();
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
          color: black, fontWeight: FontWeight.w500, fontSize: 22),
      controller: dateController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, bottom: 30, right: 20),
        labelText: labelText,
        labelStyle: const TextStyle(
            color: gray, fontWeight: FontWeight.w400, fontSize: 20),
        filled: false,
        suffixIcon: const Icon(
          Icons.date_range_rounded,
          color: red2,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: red2, width: 2)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: red2, width: 2),
        ),
      ),
      readOnly: true,
      onTap: () async {
        String? pickDate =
            await selectDate(context: context, dateController: dateController);
        // context.read<DateBloc>().add(ChangeDateEvent(pickDate!));
        // return pickDate;
      },
    );
  }
}

Future<String?> selectDate(
    {required BuildContext context,
    required TextEditingController dateController}) async {
  DateTime? pickDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1600),
    lastDate: DateTime.now(),
    cancelText: '',
  );

  if (pickDate != null) {
    dateController.text = pickDate.toString().split(" ")[0];
    return dateController.text;
  }
  return null;
}
