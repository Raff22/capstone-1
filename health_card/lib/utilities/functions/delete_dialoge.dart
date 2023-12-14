import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';

Future<dynamic> deleteAlert(
    {required BuildContext context,
    required String content,
    required Function() onPressed}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: TextWidget(text: 'deleteDialog.title'.tr()),
      content: TextWidget(
        text: content,
        fontSizeText: 20,
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: TextWidget(
            text: 'deleteDialog.yes'.tr(),
            colorText: red2,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: TextWidget(
            text: 'deleteDialog.cancel'.tr(),
            colorText: red2,
          ),
        )
      ],
    ),
  );
}
