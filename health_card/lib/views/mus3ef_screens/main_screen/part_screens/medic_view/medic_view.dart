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
import 'package:health_card/views/mus3ef_screens/custom_wedgets/allergies.dart';
import 'package:health_card/views/mus3ef_screens/custom_wedgets/cronic.dart';

class MedicView extends StatelessWidget {
  const MedicView({super.key});

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = PersonalInfo();
    MedicalInformation medicalInformation = MedicalInformation();
    Patient patient = Patient();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: red2,
          ),
        ),
        title: TextWidget(
          text: 'information',
          fontSizeText: 20,
        ),
        actions: [],
      ),
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
                      CronicDisease(
                        chronicDisease: state.chronicDisease,
                        patient: patient,
                      ),
                      height20,
                      TextWidget(
                        text: 'medical_inforamtion.allergens'.tr(),
                        fontSizeText: 20,
                      ),
                      height20,
                      Alergises(
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
