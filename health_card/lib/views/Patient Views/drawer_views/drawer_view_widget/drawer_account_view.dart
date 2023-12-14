// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/app_data/data.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/date_picker_widget.dart';
import 'package:health_card/global/global_widgets/drop_down_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/patient_model.dart';

final dropdownBloodTypeFormKey = GlobalKey<FormState>();
final dropdownRelationshipToPatientFormKey = GlobalKey<FormState>();

class DrawerAccountView extends StatelessWidget {
  DrawerAccountView({super.key, required this.patient});
  final Patient patient;

  TextEditingController nationalIdController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController emergencyPhoneController = TextEditingController();
  String? bloodTypeValue;
  String? relationship;

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = PersonalInfo();
    nationalIdController.text = personalInfo.nationalId ?? '';
    birthdayController.text = personalInfo.birthday ?? '';

    return Scaffold(
        appBar: AppBarWidget(
          context,
          'drawer_account.title_screen'.tr(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                final PersonalInfo patientInfo = PersonalInfo(
                    nationalId: nationalIdController.text,
                    birthday: birthdayController.text,
                    height: double.parse(heightController.text),
                    weight: double.parse(weightController.text),
                    bloodType: bloodTypeValue);

                context
                    .read<PatientBloc>()
                    .add(AddPatientInfoEvent(patientInfo, patient));
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BlocBuilder<PatientBloc, PatientBlocSatet>(
              builder: (context, state) {
                if (state is SucssessPatientDataState) {
                  print(state.personalInfo.nationalId);
                  personalInfo = state.personalInfo;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'drawer_account.title'.tr(),
                      fontWeightText: FontWeight.w500,
                      fontSizeText: 20,
                    ),
                    height8,
                    TextWidget(text: 'drawer_account.hint_title'.tr()),
                    height18,
                    TextFieldWidget(
                        controller: nationalIdController,
                        labelText: 'drawer_account.national_id'.tr()),
                    height18,
                    DatePickerWidget(
                      labelText: 'drawer_account.birthday'.tr(),
                      dateController: birthdayController,
                    ),
                    height18,
                    TextFieldWidget(
                        controller: heightController,
                        labelText: 'drawer_account.height'.tr()),
                    height18,
                    TextFieldWidget(
                        controller: weightController,
                        labelText: 'drawer_account.weight'.tr()),
                    height18,
                    DropDownWidget(
                      dropdownFormKey: dropdownBloodTypeFormKey,
                      hintTextDropDownMenu: 'drawer_account.blood_type'.tr(),
                      dropdownItems: bloodType,
                      onSelect: (newValue) {
                        bloodTypeValue = newValue!;
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
