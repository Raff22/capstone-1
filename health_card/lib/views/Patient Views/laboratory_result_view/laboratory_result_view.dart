// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/add_new_info_model_sheet_widget.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class LaboratoryResult extends StatelessWidget {
  LaboratoryResult({super.key});

  TextEditingController labResultDateController = TextEditingController();
  TextEditingController labResultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context,
          'laboratory_result.title_screen'.tr(),
          AddNewInfoModelSheetWidget(
            prosessDateController: labResultDateController,
            prosessNameController: labResultController,
            titleAddInfo: 'laboratory_result.title_add_info'.tr(),
            nameLabelText: 'laboratory_result.name_label_text'.tr(),
            dateLabelText: 'laboratory_result.date_label_text'.tr(),
            onPressed: () {},
            type: 'lab',
          )),
      body: SizedBox(
        height: context.getHeight(),
        width: context.getWidth(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              ContainerWidget(
                height: 100,
                width: context.getWidth(divide: 1.15),
                borderColor: noColor,
                borderWidth: 0,
                borderRadius: 20,
                containerColor: white,
                blurRadius: 20,
                shadowColor: const Color.fromARGB(34, 0, 0, 0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text:
                                '${'laboratory_result.laboratory_result_name'.tr()} ${'laboratory_result.laboratory_name'.tr()} ',
                          ),
                          TextWidget(
                            text:
                                '${'laboratory_result.laboratory_result_date'.tr()} 02/03/2023',
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.file_present_rounded,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
