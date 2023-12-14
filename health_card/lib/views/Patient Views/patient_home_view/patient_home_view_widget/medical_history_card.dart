import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/app_data/data.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class MedicalHistoryCard extends StatelessWidget {
  const MedicalHistoryCard({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: home.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                context.pushScreen(screen: home[index]["view"]);
                context.read<PatientBloc>().add(
                    GetdataEvent(patient.id!, patient, home[index]["type"]));
              },
              child: ContainerWidget(
                  padding: const EdgeInsets.all(10),
                  shadowColor: const Color.fromARGB(60, 0, 0, 0),
                  blurRadius: 10,
                  height: context.getWidth(divide: 4.5),
                  width: context.getWidth(divide: 4.5),
                  borderColor: noColor,
                  borderWidth: 0,
                  borderRadius: 20,
                  containerColor: white,
                  child:
                      Image.asset(home[index]["image"], scale: 6, color: red2)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              text: home[index]["title"],
              colorText: black,
              fontSizeText: 15,
              fontWeightText: FontWeight.w500,
            ),
          ],
        );
      },
    );
  }
}
