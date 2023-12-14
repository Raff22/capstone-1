// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';

import 'package:health_card/utilities/extentions/size_extentions.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
        // height: context.getWidth(divide: 10),
        width: context.getWidth(divide: 3),
        borderColor: noColor,
        borderWidth: 0,
        borderRadius: 15,
        containerColor: red2,
        blurRadius: 5,
        shadowColor: Colors.black26,
        onPressed: onPressed,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.file_download_rounded,
                color: white,
              ),
              width10,
              TextWidget(
                text: 'pick_file.buttom_name'.tr(),
                fontSizeText: 20,
                colorText: white,
              ),
            ],
          ),
        ));
  }
}
