import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/Patient%20Views/medical_information_view/edit_medical_info_view/edit_medical_info.dart';
import 'package:health_card/views/Patient%20Views/medical_information_view/medical_information_view_widget/allergens_container.dart';
import 'package:health_card/views/Patient%20Views/medical_information_view/medical_information_view_widget/chronic_disease_container.dart';
import 'package:health_card/views/Patient%20Views/medical_information_view/medical_information_view_widget/patient_information_container.dart';

class MedicalInformationView extends StatelessWidget {
  const MedicalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = PersonalInfo();
    MedicalInformation medicalInformation = MedicalInformation();
    Patient patient = Patient();

    return Scaffold(
      appBar: AppBarWidget(
          context,
          'medical_inforamtion.title_screen'.tr(),
          IconButton(
              onPressed: () {
                context.pushScreen(
                  screen: EditMedicalInfoView(
                    medicalInformation: medicalInformation,
                    patient: patient,
                  ),
                  then: (p0) {
                    if (p0 == "back") {
                      context.read<PatientBloc>().add(GetdataEvent(
                          patient.id!, patient, 'Medical Information',));
                    }
                  },
                );
              },
              icon: const Icon(Icons.mode_edit_outlined))),
      body: SizedBox(
        height: context.getHeight(),
        width: context.getWidth(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BlocBuilder<PatientBloc, PatientBlocSatet>(
              builder: (context, state) {
                if (state is SucssessPatientDataState) {
                  personalInfo = state.personalInfo;
                  medicalInformation = state.medicalInformation;
                  patient = state.patient;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'medical_inforamtion.patient_information'.tr(),
                        fontSizeText: 20,
                      ),
                      height20,
                      PatientInfoContainer(
                        personalInfo: personalInfo,
                        patient: state.patient,
                        medicalInformation: state.medicalInformation,
                      ),
                      height20,
                      TextWidget(
                        text: 'medical_inforamtion.chronic_disease'.tr(),
                        fontSizeText: 20,
                      ),
                      height20,
                      ChronicDiseaseContainer(
                        chronicDisease: state.chronicDisease,
                        patient: patient,
                      ),
                      height20,
                      TextWidget(
                        text: 'medical_inforamtion.allergens'.tr(),
                        fontSizeText: 20,
                      ),
                      height20,
                      AllergensContainer(
                        allergies: state.allergies,
                        patient: patient,
                      ),
                      height30,
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: red2,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
