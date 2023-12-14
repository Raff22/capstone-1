import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/Patient%20Views/patient_home_view/patient_home_view_widget/patient_zoom_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:screenshot/screenshot.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient});
  final Patient patient;
  // ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = PersonalInfo();

    return Center(
      child: ContainerWidget(
        shadowColor: const Color.fromARGB(34, 0, 0, 0),
        blurRadius: 20,
        width: context.getWidth(divide: 1.15),
        borderColor: blue,
        borderWidth: 2,
        padding: const EdgeInsets.all(3),
        borderRadius: 16,
        containerColor: white,
        child: BlocBuilder<PatientBloc, PatientBlocSatet>(
          builder: (context, state) {
            if (state is SucssessPatientInfoCardState) {
              personalInfo = state.personalInfo;
              profileImage = personalInfo.image!;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.getWidth(divide: 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'patient_information.patient_name'.tr(),
                          fontWeightText: FontWeight.bold,
                          fontSizeText: 15,
                        ),
                        TextWidget(
                          text: patient.fullName ?? "",
                          fontSizeText: 15,
                        ),
                        height4,
                        Row(
                          children: [
                            TextWidget(
                              text: 'patient_information.national_id'.tr(),
                              fontWeightText: FontWeight.bold,
                              fontSizeText: 13,
                            ),
                            width6,
                            TextWidget(
                              text: personalInfo.nationalId ?? "110xxxxxxx",
                              fontSizeText: 13,
                            ),
                          ],
                        ),
                        height4,
                        Row(
                          children: [
                            TextWidget(
                              text: 'patient_information.patient_date'.tr(),
                              fontWeightText: FontWeight.bold,
                              fontSizeText: 13,
                            ),
                            width6,
                            TextWidget(
                              text: personalInfo.birthday ?? "mm/dd/yyyy",
                            ),
                          ],
                        ),
                        height4,
                        Row(
                          children: [
                            TextWidget(
                              text:
                                  'patient_information.patient_blood_type'.tr(),
                              fontWeightText: FontWeight.bold,
                              fontSizeText: 13,
                            ),
                            width6,
                            TextWidget(
                              text: personalInfo.bloodType ?? "A+",
                              fontSizeText: 12,
                            ),
                          ],
                        ),
                        height4,
                        Row(
                          children: [
                            TextWidget(
                              text: 'patient_information.patient_height'.tr(),
                              fontWeightText: FontWeight.bold,
                              fontSizeText: 13,
                            ),
                            width6,
                            TextWidget(
                              text: ' ${personalInfo.height ?? ""}',
                              fontSizeText: 13,
                            ),
                          ],
                        ),
                        height4,
                        Row(
                          children: [
                            TextWidget(
                              text: 'patient_information.patient_weight'.tr(),
                              fontWeightText: FontWeight.bold,
                              fontSizeText: 13,
                            ),
                            width6,
                            TextWidget(
                              text: ' ${personalInfo.weight ?? ""}',
                              fontSizeText: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: context.getWidth(divide: 1.75),
                  width: context.getWidth(divide: 2.90),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: TextWidget(
                                        text: 'print_medical_card.confirm_mess'
                                            .tr()),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Center(
                                            child: TextWidget(
                                          text: 'print_medical_card.ok'.tr(),
                                          colorText: red2,
                                          fontSizeText: 18,
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.print_rounded)),
                          IconButton(
                              onPressed: () {
                                context.pushScreen(screen: PatientZoomCard(patient: patient,));
                              },
                              icon: const Icon(Icons.zoom_out_map_rounded)),
                        ],
                      ),
                      height20,
                      ContainerWidget(
                        shadowColor: const Color.fromARGB(34, 0, 0, 0),
                        blurRadius: 20,
                        height: context.getWidth(divide: 3.5),
                        width: context.getWidth(divide: 3.5),
                        borderColor: blue,
                        borderWidth: 2,
                        borderRadius: 20,
                        containerColor: white,
                        child: QrImageView(
                          data: patient.id.toString(),
                          size: 50,
                          padding: const EdgeInsets.all(10),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<dynamic> ShowCapturedWidget(
    BuildContext context, Uint8List capturedImage) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text("Captured your Card"),
      ),
      body: Center(child: Image.memory(capturedImage)),
    ),
  );
}
