// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/date_picker_widget.dart';
import 'package:health_card/global/global_widgets/file_picker_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

// this custom widget for adding
// - new Sergury
// - new X-Rays
// - new Lab Result

class AddNewInfoModelSheetWidget extends StatelessWidget {
  AddNewInfoModelSheetWidget(
      {super.key,
      required this.prosessDateController,
      required this.prosessNameController,
      required this.nameLabelText,
      required this.dateLabelText,
      required this.titleAddInfo,
      required this.onPressed,
      this.dropDownWidget,
      required this.type});

  TextEditingController prosessDateController;
  TextEditingController prosessNameController;
  final String nameLabelText;
  final String dateLabelText;
  final String titleAddInfo;
  final Function() onPressed;
  final Widget? dropDownWidget;
  final String type;

  @override
  Widget build(BuildContext context) {
    File? fileee;
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 80,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ContainerWidget(
                    height: context.getHeight(divide: 1.5),
                    width: context.getWidth(),
                    borderColor: noColor,
                    borderWidth: 0,
                    borderRadius: 20,
                    containerColor: noColor,
                    blurRadius: 0,
                    shadowColor: noColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: TextWidget(
                              text: titleAddInfo,
                              fontSizeText: 20,
                              fontWeightText: FontWeight.w500,
                            ),
                          ),
                          height10,
                          TextWidget(
                            text: 'add_new_info_model_sheet_widget.title_widget'
                                .tr(),
                            fontSizeText: 20,
                          ),
                          height20,
                          TextFieldWidget(
                              controller: prosessNameController,
                              labelText: nameLabelText),
                          height20,
                          DatePickerWidget(
                            labelText: dateLabelText,
                            dateController: prosessDateController,
                          ),
                          height20,
                          Container(
                            child: dropDownWidget,
                          ),
                          height20,
                          Center(
                            child: FilePickerWidget(
                              onPressed: () async {
                                print("here");
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  fileee = File(result.files.single.path!);
                                }
                              },
                            ),
                          ),
                          height10,
                          InkWell(
                            onTap: () {
                              if (prosessDateController.text.isEmpty ||
                                  prosessNameController.text.isEmpty ||
                                  fileee == null) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: TextWidget(
                                        text:
                                            'Patient_regestraion_screen.validatorMessage2'
                                                .tr()),
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
                              } else {
                                if (type == 'xray_reports') {
                                  print('here=======');
                                  context.read<PatientBloc>().add(
                                      UploadXrayReportEvent(
                                          date: prosessDateController.text,
                                          name: prosessNameController.text,
                                          pdfFile: fileee ?? File(""),
                                          patient: globalCurrentPatient!));
                                } else if (type == 'surgery_reports') {
                                  context.read<PatientBloc>().add(
                                      UploadSurgeryReportEvent(
                                          date: prosessDateController.text,
                                          name: prosessNameController.text,
                                          pdfFile: fileee ?? File(""),
                                          patient: globalCurrentPatient!));
                                }
                                context.popScreen();
                              }
                            },
                            child: Center(
                                child: TextWidget(
                              text: 'add_new_info_model_sheet_widget.send_add'
                                  .tr(),
                              colorText: red2,
                              fontSizeText: 20,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.add));
  }
}
