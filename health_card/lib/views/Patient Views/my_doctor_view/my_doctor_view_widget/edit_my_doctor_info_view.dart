// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/format_checks.dart/format_checks.dart';

class EditMyDoctorInfoView extends StatelessWidget {
  EditMyDoctorInfoView(
      {super.key, required this.patient, required this.doctor});
  final Patient patient;
  final Doctor doctor;

  TextEditingController doctorNameController = TextEditingController();
  TextEditingController doctorSpecialtyController = TextEditingController();
  TextEditingController doctorAddressController = TextEditingController();
  TextEditingController doctorEmailController = TextEditingController();
  TextEditingController doctorPhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    doctorNameController.text = doctor.name ?? '';
    doctorSpecialtyController.text = doctor.speciality ?? '';
    doctorAddressController.text = doctor.address ?? '';
    doctorEmailController.text = doctor.email ?? '';
    doctorPhoneNumberController.text = doctor.phone ?? '';

    return Scaffold(
        appBar: AppBarWidget(
          context,
          'drawer_my_doctor.title_screen'.tr(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: TextWidget(text: 'my_doctor_view.confirm_mess'.tr()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Center(
                            child: TextWidget(
                          text: 'my_doctor_view.OK'.tr(),
                          colorText: red2,
                        )),
                      ),
                    ],
                  ),
                );
                // if (FormatCheck()
                //     .checkEmailFormat(doctorEmailController.text)) {
                //   if (FormatCheck()
                //       .checkPhone(doctorPhoneNumberController.text)) {

                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         content: TextWidget(
                //       text: 'Phone number is wrokng',
                //     )));
                //   }
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //       content: TextWidget(
                //     text: 'email is wrokng',
                //   )));
                // }
                final Doctor doctor = Doctor(
                    name: doctorNameController.text,
                    speciality: doctorSpecialtyController.text,
                    address: doctorAddressController.text,
                    email: doctorEmailController.text,
                    phone: doctorPhoneNumberController.text);

                if (doctor.id == null) {
                  context
                      .read<PatientBloc>()
                      .add(AddPatientDoctorInfoEvent(doctor, patient));
                } else {
                  context
                      .read<PatientBloc>()
                      .add(UpdateDoctorInfoEvent(doctor, patient));
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
                  text: 'drawer_my_doctor.title_screen'.tr(),
                  fontWeightText: FontWeight.w500,
                  fontSizeText: 20,
                ),
                height8,
                TextWidget(
                  text: 'my_doctor_view.description'.tr(),
                ),
                height18,
                TextFieldWidget(
                  controller: doctorNameController,
                  labelText: 'my_doctor_view.doctor_name'.tr(),
                ),
                height18,
                TextFieldWidget(
                  controller: doctorSpecialtyController,
                  labelText: 'my_doctor_view.doctor_specialty'.tr(),
                ),
                height18,
                TextFieldWidget(
                  controller: doctorAddressController,
                  labelText: 'my_doctor_view.doctor_address'.tr(),
                ),
                height18,
                TextFieldWidget(
                  controller: doctorEmailController,
                  labelText: 'my_doctor_view.doctor_email'.tr(),
                ),
                height18,
                TextFieldWidget(
                  controller: doctorPhoneNumberController,
                  labelText: 'my_doctor_view.doctor_phone'.tr(),
                ),
                height18,
              ],
            ),
          ),
        ));
  }
}
