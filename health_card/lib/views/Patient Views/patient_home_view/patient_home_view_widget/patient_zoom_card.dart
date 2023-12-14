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
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class PatientZoomCard extends StatefulWidget {
  const PatientZoomCard({super.key, required this.patient});

  final Patient patient;

  @override
  State<PatientZoomCard> createState() => _PatientZoomCardState();
}

class _PatientZoomCardState extends State<PatientZoomCard> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = PersonalInfo();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: Center(
            child: ContainerWidget(
              shadowColor: const Color.fromARGB(34, 0, 0, 0),
              blurRadius: 20,
              width: context.getWidth(),
              borderColor: blue,
              borderWidth: 2,
              padding: const EdgeInsets.all(5),
              borderRadius: 16,
              containerColor: white,
              child: BlocBuilder<PatientBloc, PatientBlocSatet>(
                builder: (context, state) {
                  if (state is SucssessPatientInfoCardState) {
                    personalInfo = state.personalInfo;
                    profileImage = personalInfo.image!;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: context.getWidth(divide: 2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'patient_information.patient_name'.tr(),
                                fontWeightText: FontWeight.bold,
                                fontSizeText: 24,
                              ),
                              TextWidget(
                                text: widget.patient.fullName ?? "",
                                fontSizeText: 24,
                              ),
                              height4,
                              Row(
                                children: [
                                  TextWidget(
                                    text:
                                        'patient_information.national_id'.tr(),
                                    fontWeightText: FontWeight.bold,
                                    fontSizeText: 24,
                                  ),
                                  width6,
                                  TextWidget(
                                    text:
                                        personalInfo.nationalId ?? "110xxxxxxx",
                                    fontSizeText: 24,
                                  ),
                                ],
                              ),
                              height4,
                              Row(
                                children: [
                                  TextWidget(
                                    text:
                                        'patient_information.patient_date'.tr(),
                                    fontWeightText: FontWeight.bold,
                                    fontSizeText: 24,
                                  ),
                                  width6,
                                  TextWidget(
                                    text: personalInfo.birthday ?? "mm/dd/yyyy",
                                    fontSizeText: 24,
                                  ),
                                ],
                              ),
                              height4,
                              Row(
                                children: [
                                  TextWidget(
                                    text:
                                        'patient_information.patient_blood_type'
                                            .tr(),
                                    fontWeightText: FontWeight.bold,
                                    fontSizeText: 24,
                                  ),
                                  width6,
                                  TextWidget(
                                    text: personalInfo.bloodType ?? "A+",
                                    fontSizeText: 24,
                                  ),
                                ],
                              ),
                              height4,
                              Row(
                                children: [
                                  TextWidget(
                                    text: 'patient_information.patient_height'
                                        .tr(),
                                    fontWeightText: FontWeight.bold,
                                    fontSizeText: 24,
                                  ),
                                  width6,
                                  TextWidget(
                                    text: ' ${personalInfo.height ?? ""}',
                                    fontSizeText: 24,
                                  ),
                                ],
                              ),
                              height4,
                              Row(
                                children: [
                                  TextWidget(
                                    text: 'patient_information.patient_weight'
                                        .tr(),
                                    fontWeightText: FontWeight.bold,
                                    fontSizeText: 24,
                                  ),
                                  width6,
                                  TextWidget(
                                    text: ' ${personalInfo.weight ?? ""}',
                                    fontSizeText: 24,
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
                                              text:
                                                  'print_medical_card.confirm_mess'
                                                      .tr()),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Center(
                                                  child: TextWidget(
                                                text: 'print_medical_card.ok'
                                                    .tr(),
                                                colorText: red2,
                                                fontSizeText: 18,
                                              )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.print_rounded,
                                      size: 24,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      context.popScreen();
                                    },
                                    child: const TextWidget(
                                      text: 'X',
                                      colorText: red2,
                                      fontSizeText: 24,
                                    )),
                              ],
                            ),
                            height20,
                            ContainerWidget(
                              shadowColor: const Color.fromARGB(34, 0, 0, 0),
                              blurRadius: 20,
                              height: context.getWidth(divide: 4.5),
                              width: context.getWidth(divide: 4.5),
                              borderColor: blue,
                              borderWidth: 2,
                              borderRadius: 20,
                              containerColor: white,
                              child: QrImageView(
                                data: widget.patient.id.toString(),
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
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }
}
