import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class DoctorPicture extends StatelessWidget {
  const DoctorPicture({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ContainerWidget(
        height: context.getHeight(divide: 7),
        width: context.getWidth(divide: 1),
        borderColor: noColor,
        borderWidth: 0,
        borderRadius: 20,
        containerColor: noColor,
        shadowColor: noColor,
        blurRadius: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/doctor.png",
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                height: context.getHeight(),
                width: context.getWidth(divide: 1.95),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'my_doctor_view.practice_name'.tr(),
                      fontSizeText: 20,
                    ),
                    TextWidget(
                      text: doctor.name ?? '',
                      fontSizeText: 18,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
