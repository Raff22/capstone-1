import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class PatientInfoContainer extends StatelessWidget {
  const PatientInfoContainer(
      {super.key, this.personalInfo, this.patient, this.medicalInformation});
  final PersonalInfo? personalInfo;
  final Patient? patient;
  final MedicalInformation? medicalInformation;

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = PersonalInfo();
    MedicalInformation medicalInformation = MedicalInformation();
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: BlocBuilder<PatientBloc, PatientBlocSatet>(
            builder: (context, state) {
              if (state is SucssessPatientDataState) {
                personalInfo = state.personalInfo;
                medicalInformation = state.medicalInformation;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text:
                        '${'patient_information.national_id'.tr()} ${personalInfo.nationalId ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'patient_information.patient_name'.tr()} ${patient!.fullName ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'patient_information.patient_date'.tr()} ${personalInfo.birthday ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'patient_information.patient_blood_type'.tr()} ${personalInfo.bloodType ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'patient_information.patient_height'.tr()} ${personalInfo.height ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'patient_information.patient_weight'.tr()} ${personalInfo.weight ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'patient_information.smooker'.tr()} ${medicalInformation.isSmoker ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'medical_inforamtion.communication_challenge'.tr()} ${medicalInformation.communication ?? ''}',
                  ),
                  height8,
                  TextWidget(
                    text:
                        '${'medical_inforamtion.medical_device'.tr()} ${medicalInformation.medicalCondition ?? ''}',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
