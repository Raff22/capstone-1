import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class DoctorPicture extends StatelessWidget {
  DoctorPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ContainerWidget(
        height: 120,
        width: context.getWidth(divide: 1.15),
        borderColor: noColor,
        borderWidth: 0,
        borderRadius: 20,
        containerColor: noColor,
        shadowColor: noColor,
        blurRadius: 0,
      ),
    );
  }
}
