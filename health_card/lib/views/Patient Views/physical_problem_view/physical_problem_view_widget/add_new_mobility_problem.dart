// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/app_data/data.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/drop_down_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

final dropdownMobilityProblrmTypeFormKey = GlobalKey<FormState>();
final dropdownMobilityProblrmPlacementFormKey = GlobalKey<FormState>();

class AddNewMobilityProblem extends StatelessWidget {
  AddNewMobilityProblem(
      {super.key,
      required this.problemNameController,
      required this.problemDescriptionController,
      required this.nameLabelText,
      required this.titleAddInfo,
      required this.onPressed,
      this.mobilityType,
      this.mobilityPlace,
      this.patient});

  TextEditingController problemNameController;
  TextEditingController problemDescriptionController;
  final String nameLabelText;
  final String titleAddInfo;
  final Function() onPressed;
  String? mobilityType;
  String? mobilityPlace;
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
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
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ContainerWidget(
                    // height: context.getHeight(),
                    width: context.getWidth(),
                    borderColor: noColor,
                    borderWidth: 0,
                    borderRadius: 20,
                    containerColor: noColor,
                    blurRadius: 0,
                    shadowColor: noColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: TextWidget(
                              text: titleAddInfo,
                              fontSizeText: 20,
                              fontWeightText: FontWeight.w500,
                            ),
                          ),
                          height30,
                          TextWidget(
                            text: 'add_new_info_model_sheet_widget.title_widget'
                                .tr(),
                            fontSizeText: 20,
                          ),
                          height20,
                          TextFieldWidget(
                              controller: problemNameController,
                              labelText: nameLabelText),
                          height20,
                          DropDownWidget(
                            dropdownFormKey: dropdownMobilityProblrmTypeFormKey,
                            hintTextDropDownMenu:
                                'dropDownPhysicalProblrmType.hint_text_type'
                                    .tr(),
                            dropdownItems: physicalProblrmType,
                            onSelect: (newValue) {
                              mobilityType = newValue;
                            },
                          ),
                          height20,
                          DropDownWidget(
                            dropdownFormKey:
                                dropdownMobilityProblrmPlacementFormKey,
                            hintTextDropDownMenu:
                                'dropDownPlacementIssue.hint_text_physical_place'
                                    .tr(),
                            dropdownItems: placementIssue,
                            onSelect: (newValue) {
                              mobilityPlace = newValue;
                            },
                          ),
                          height30,
                          Center(
                            child: ContainerWidget(
                              height: context.getWidth(divide: 10),
                              width: context.getWidth(divide: 3),
                              borderColor: noColor,
                              borderWidth: 0,
                              borderRadius: 0,
                              containerColor: noColor,
                              blurRadius: 0,
                              shadowColor: noColor,
                              onPressed: () {
                                context.popScreen();
                                print("1");
                                print(problemNameController.text);
                                print(mobilityType);
                                print(mobilityPlace);
                                if (problemNameController.text.isNotEmpty &&
                                    mobilityType != null &&
                                    mobilityPlace != null) {
                                  print("2");

                                  final MobilityProblem mobilityProblem =
                                      MobilityProblem(
                                          problemName:
                                              problemNameController.text,
                                          problemType: mobilityType,
                                          problemPlace: mobilityPlace,
                                          patientId: patient!.id);
                                  print("3");

                                  context.read<PatientBloc>().add(
                                      AddPatientMobilityProblemEvent(
                                          mobilityProblem,
                                          patient!.id.toString(),
                                          patient!));
                                } else {
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: TextWidget(
                                          text:
                                              'Patient_regestraion_screen.validatorMessage2'
                                                  .tr()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Center(
                                              child: TextWidget(
                                            text: 'my_doctor_view.OK'.tr(),
                                            colorText: red2,
                                          )),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                problemNameController.clear();
                              },
                              child: Center(
                                  child: TextWidget(
                                text: 'add_new_info_model_sheet_widget.send_add'
                                    .tr(),
                                colorText: red2,
                                fontSizeText: 20,
                              )),
                            ),
                          )
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
