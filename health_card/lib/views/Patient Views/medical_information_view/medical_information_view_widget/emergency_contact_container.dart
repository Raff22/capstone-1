import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class EmergencyContactContainer extends StatelessWidget {
  const EmergencyContactContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ContainerWidget(
        height: 300,
        width: context.getWidth(divide: 1.15),
        borderColor: noColor,
        borderWidth: 0,
        borderRadius: 20,
        containerColor: white,
        blurRadius: 10,
        shadowColor: const Color.fromARGB(34, 0, 0, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text:
                    '${'emergency_contact.emergency_name'.tr()} Waleed Alqahtani',
              ),
              TextWidget(
                text:
                    '${'emergency_contact.emergency_phone_number'.tr()} 0554796100',
              ),
              TextWidget(
                text:
                    '${'emergency_contact.emergency_relationship'.tr()} father',
              ),
              const Divider(),
              TextWidget(
                text:
                    '${'emergency_contact.emergency_name'.tr()} Mohannad Alqahtani',
              ),
              TextWidget(
                text:
                    '${'emergency_contact.emergency_phone_number'.tr()} 0554796800',
              ),
              TextWidget(
                text:
                    '${'emergency_contact.emergency_relationship'.tr()} brother',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
