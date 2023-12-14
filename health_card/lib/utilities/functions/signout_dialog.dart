import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';

Future<dynamic> signOutAlert(
    {required BuildContext context,
    required String content,
    required Function() onPressed}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: TextWidget(text: 'deleteDialog.titlesignout'.tr()),
      content: TextWidget(
        text: content,
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text('deleteDialog.yes'.tr()),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text('deleteDialog.cancel'.tr()),
        )
      ],
    ),
  );
}
