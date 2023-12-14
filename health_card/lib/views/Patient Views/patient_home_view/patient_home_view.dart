import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/get_first_word.dart';
import 'package:health_card/views/Patient%20Views/drawer_views/drawer_widget_view.dart';
import 'package:health_card/views/Patient%20Views/patient_home_view/patient_home_view_widget/medical_history_card.dart';
import 'package:health_card/views/Patient%20Views/patient_home_view/patient_home_view_widget/patient_card.dart';

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    context.read<PatientBloc>().add(GetPatientInfoCardEvent(patient));
    final firstName = getFirstWords(patient.fullName!);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 35),
      ),
      drawer: DrawerWidgetView(
        patient: patient,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text:
                        '${'patient_home_screen.welcoming_word'.tr()}, $firstName',
                    fontWeightText: FontWeight.w600,
                    fontSizeText: 40,
                  ),
                  TextWidget(
                    text: 'patient_home_screen.patient_card_title'.tr(),
                    fontSizeText: 25,
                    colorText: black,
                  ),
                ],
              ),
            ),
            PatientCard(
              patient: patient,
            ),
            height20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                text: 'patient_home_screen.patient_history_title'.tr(),
                fontSizeText: 25,
                colorText: black,
              ),
            ),
            MedicalHistoryCard(
              patient: patient,
            ),
            height30
          ],
        ),
      ),
    );
  }
}
