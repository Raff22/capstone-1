import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class CommunicationChallengeContainer extends StatelessWidget {
  const CommunicationChallengeContainer({super.key, this.medicalInformation});

  final MedicalInformation? medicalInformation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ContainerWidget(
        width: context.getWidth(divide: 1.15),
        borderColor: noColor,
        borderWidth: 0,
        borderRadius: 20,
        containerColor: white,
        blurRadius: 10,
        shadowColor: const Color.fromARGB(34, 0, 0, 0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: medicalInformation!.communication ?? '',
                colorText: gray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
