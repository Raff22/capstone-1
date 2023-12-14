// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class AddNewMedication extends StatelessWidget {
  AddNewMedication(
      {super.key,
      required this.medicationUnitController,
      required this.medicationNameController,
      required this.medicationTimeController,
      required this.nameLabelText,
      required this.titleAddInfo,
      required this.onPressed,
      required this.unitLabelText,
      required this.timeLabelText});

  TextEditingController medicationUnitController;
  TextEditingController medicationNameController;
  TextEditingController medicationTimeController;
  final String nameLabelText;
  final String unitLabelText;
  final String timeLabelText;

  final String titleAddInfo;
  final Function() onPressed;

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
                    // height: context.getHeight(divide: 1.50),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                              controller: medicationNameController,
                              labelText: nameLabelText),
                          height20,
                          TextFieldWidget(
                              controller: medicationUnitController,
                              labelText: unitLabelText),
                          height20,
                          TextFieldWidget(
                              controller: medicationTimeController,
                              labelText: timeLabelText),
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
                              onPressed: onPressed,
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
