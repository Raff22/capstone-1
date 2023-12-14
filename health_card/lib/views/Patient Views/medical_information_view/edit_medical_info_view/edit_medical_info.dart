// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/app_data/data.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/drop_down_widget.dart';
import 'package:health_card/global/global_widgets/row_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';

import 'package:health_card/views/Patient%20Views/medical_information_view/edit_medical_info_view/add_allergens.dart';
import 'package:health_card/views/Patient%20Views/medical_information_view/edit_medical_info_view/add_chronic_diseases.dart';

final dropdownIsSmookerFormKey = GlobalKey<FormState>();
String isSmopker = '';

class EditMedicalInfoView extends StatelessWidget {
  EditMedicalInfoView(
      {super.key, required this.patient, this.medicalInformation});
  Patient patient;
  MedicalInformation? medicalInformation;
  TextEditingController medicalDeviceController = TextEditingController();
  TextEditingController communicationChallangeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // if (medicalInformation != null) {
    //   medicalDeviceController.text = medicalInformation!.communication!;
    //   communicationChallangeController.text =
    //       medicalInformation!.medicalCondition!;
    // }
    return Scaffold(
        appBar: AppBarWidget(
          context,
          'drawer_medical_inforamtion.title_screen'.tr(),
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
                final MedicalInformation medicalInformation2 =
                    MedicalInformation(
                        communication: communicationChallangeController.text,
                        medicalCondition: medicalDeviceController.text,
                        isSmoker: isSmopker);
                if (patient.medicalInformationId == null) {
                  print("dosent have");
                  context.read<PatientBloc>().add(
                      AddPatientMediclaInfoEvent(medicalInformation2, patient));
                } else {
                  print(" have");
                  medicalInformation2.id = medicalInformation!.id!;
                  context
                      .read<PatientBloc>()
                      .add(UpdatePatientMedicalInfoInfoEvent(
                        medicalInformation: medicalInformation2,
                        patient: patient,
                      ));
                }

                print(communicationChallangeController.text);
                print(medicalDeviceController.text);
                print(isSmopker);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height8,
                TextWidget(
                  text: 'edit_medical_info.title'.tr(),
                  fontSizeText: 20,
                ),
                height18,
                const Divider(),
                RowWidget(
                  text: 'edit_medical_info.chronic_diseases'.tr(),
                  icon: TextWidget(
                    text: 'drawer_emergency_contact.save'.tr(),
                    fontSizeText: 15,
                    colorText: red2,
                  ),
                  onPressed: () {
                    context.pushScreen(
                        screen: AddChronicDiseases(
                      patient: patient,
                    ));
                  },
                ),
                const Divider(),
                RowWidget(
                  text: 'edit_medical_info.allergens'.tr(),
                  onPressed: () {
                    context.pushScreen(
                        screen: AddAllergens(
                      patient: patient,
                    ));
                  },
                  icon: TextWidget(
                    text: 'drawer_emergency_contact.save'.tr(),
                    fontSizeText: 15,
                    colorText: red2,
                  ),
                ),
                const Divider(),
                height20,
                TextWidget(
                  text: 'edit_medical_info.hint_title'.tr(),
                  colorText: black,
                  fontSizeText: 20,
                  fontWeightText: FontWeight.w300,
                ),
                height20,
                TextFieldWidget(
                    controller: communicationChallangeController,
                    labelText: 'edit_medical_info.communication'.tr()),
                height20,
                TextFieldWidget(
                    controller: medicalDeviceController,
                    labelText: 'edit_medical_info.medical_device'.tr()),
                height20,
                DropDownWidget(
                  dropdownFormKey: dropdownIsSmookerFormKey,
                  hintTextDropDownMenu: 'edit_medical_info.smooker'.tr(),
                  dropdownItems: isSmookerStatus,
                  onSelect: (newValue) {
                    isSmopker = newValue!;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
