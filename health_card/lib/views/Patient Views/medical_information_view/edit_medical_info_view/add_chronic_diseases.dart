// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/chronic_disease_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/views/Patient%20Views/medical_information_view/medical_information_view.dart';

class AddChronicDiseases extends StatelessWidget {
  AddChronicDiseases({super.key, required this.patient});
  final Patient patient;

  TextEditingController chronicDiseasesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context,
        'edit_medical_info.chronic_diseases'.tr(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title:
                      TextWidget(text: 'edit_medical_info.confirm_mess'.tr()),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Center(
                          child: TextWidget(
                        text: 'edit_medical_info.ok'.tr(),
                        colorText: red2,
                      )),
                    ),
                  ],
                ),
              );
              final ChronicDisease chronicDisease =
                  ChronicDisease(disease: chronicDiseasesController.text);
              print(chronicDiseasesController.text);
              print(patient.id);
              context.read<PatientBloc>().add(AddPatientChronicDiseasesEvent(
                  chronicDisease, patient.id.toString(), patient));
            },
            child: TextWidget(
              text: 'drawer_account.save'.tr(),
              colorText: red2,
              fontSizeText: 18,
              fontWeightText: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'edit_medical_info.chronic_diseases_title'.tr(),
                fontSizeText: 18,
              ),
              height10,
              TextFieldWidget(
                  controller: chronicDiseasesController,
                  labelText: 'edit_medical_info.add_chronic_diseases'.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
