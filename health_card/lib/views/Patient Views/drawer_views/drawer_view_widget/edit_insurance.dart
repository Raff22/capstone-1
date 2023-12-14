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
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/insurance_model.dart';
import 'package:health_card/models/patient_model.dart';

final dropdownInsuranceStatusFormKey = GlobalKey<FormState>();

class EditInsurance extends StatelessWidget {
  EditInsurance({super.key, required this.patient, required this.insurance});
  final Patient patient;
  final InsuranceModel insurance;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController patientInsuranceIdController = TextEditingController();
  TextEditingController coverageController = TextEditingController();
  TextEditingController contactsController = TextEditingController();
  String? insuranceStatusValue = '';

  @override
  Widget build(BuildContext context) {
    companyNameController.text = insurance.companyName ?? '';
    patientInsuranceIdController.text = insurance.patientInsuranceId ?? '';
    coverageController.text = insurance.coverage ?? '';
    contactsController.text = insurance.contacts ?? '';

    return Scaffold(
        appBar: AppBarWidget(
          context,
          'insurance_drawer.app_title'.tr(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title:
                        TextWidget(text: 'insurance_drawer.confirm_mess'.tr()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Center(
                            child: TextWidget(
                          text: 'insurance_drawer.ok'.tr(),
                          colorText: red2,
                        )),
                      ),
                    ],
                  ),
                );
                final insuranceId = insurance.id;
                // print('dddd ${insurance.id}');
                final InsuranceModel insurancee = InsuranceModel(
                    companyName: companyNameController.text,
                    patientInsuranceId: patientInsuranceIdController.text,
                    coverage: coverageController.text,
                    contacts: contactsController.text,
                    status: insuranceStatusValue);
                print('i am in the ui : id =${insurance.id}');
                print('dddd ${insuranceId}');

                if (insurance.id == null) {
                  context
                      .read<PatientBloc>()
                      .add(AddPatientInsuranceInfoEvent(insurancee, patient));
                } else {
                  context
                      .read<PatientBloc>()
                      .add(UpdateInsuranceEvent(insurance, patient,insuranceId!));
                }
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
                TextWidget(
                  text: 'insurance_drawer.hint_title'.tr(),
                  fontWeightText: FontWeight.w500,
                  fontSizeText: 20,
                ),
                height10,
                TextFieldWidget(
                    controller: companyNameController,
                    labelText: 'insurance_drawer.edit_company_name'.tr()),
                height18,
                TextFieldWidget(
                    controller: patientInsuranceIdController,
                    labelText:
                        'insurance_drawer.edit_patient_insurens_id'.tr()),
                height18,
                TextFieldWidget(
                    controller: coverageController,
                    labelText: 'insurance_drawer.edit_coverage'.tr()),
                height18,
                TextFieldWidget(
                    controller: contactsController,
                    labelText: 'insurance_drawer.edit_contact'.tr()),
                height18,
                DropDownWidget(
                  dropdownFormKey: dropdownInsuranceStatusFormKey,
                  hintTextDropDownMenu: 'insurance_drawer.edit_status'.tr(),
                  dropdownItems: insuranceStatus,
                  onSelect: (newValue) {
                    insuranceStatusValue = newValue!;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
