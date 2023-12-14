// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/app_data/data.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/add_new_info_model_sheet_widget.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/drop_down_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/surgery_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/delete_dialoge.dart';
import 'package:url_launcher/url_launcher.dart';

final dropdownSerguryPlacementFormKey = GlobalKey<FormState>();

class SurgicalRecordView extends StatelessWidget {
  SurgicalRecordView({super.key});

  TextEditingController surgeryDateController = TextEditingController();
  TextEditingController surgeryNameController = TextEditingController();
  String? serguryPlace;

  @override
  Widget build(BuildContext context) {
    print("in surgery");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarWidget(
            context,
            'surgical_record.title_screen'.tr(),
            AddNewInfoModelSheetWidget(
              prosessDateController: surgeryDateController,
              prosessNameController: surgeryNameController,
              titleAddInfo: 'surgical_record.title_add_info'.tr(),
              nameLabelText: 'surgical_record.name_label_text'.tr(),
              dateLabelText: 'surgical_record.date_label_text'.tr(),
              onPressed: () {},
              dropDownWidget: DropDownWidget(
                dropdownFormKey: dropdownSerguryPlacementFormKey,
                hintTextDropDownMenu:
                    'dropDownPlacementIssue.hint_text_surgical_place'.tr(),
                dropdownItems: placementIssue,
                onSelect: (newValue) {
                  serguryPlace = newValue!;
                },
              ),
              type: 'surgery_reports',
            ),
          ),
          body: SizedBox(
            height: context.getHeight(),
            width: context.getWidth(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: BlocBuilder<PatientBloc, PatientBlocSatet>(
                  builder: (context, state) {
                if (state is UpdateSurgeryListState) {
                  surgeryNameController.clear();
                  surgeryDateController.clear();
                  print("here");
                  if (state.surgeries.isEmpty) {
                    return Center(
                        child: TextWidget(
                      text: 'x-rays_reports.suggestion'.tr(),
                      fontSizeText: 20,
                      fontWeightText: FontWeight.w500,
                    ));
                  } else {
                    return ListView.builder(
                      itemCount: state.surgeries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: const Key("index"),
                          confirmDismiss: (direction) async {
                            final x = await deleteAlert(
                                context: context,
                                content: state.surgeries[index].label!,
                                onPressed: () {
                                  context.read<PatientBloc>().add(
                                      DeleteSurgeryEvent(
                                          surgeryId: state.surgeries[index].id!,
                                          patientId:
                                              globalCurrentPatient!.id!));
                                  context.popScreen();
                                });
                            return Future.value(x == 'cancel');
                          },
                          child: SurgeryWidget(
                            surgery: state.surgeries[index],
                          ),
                        );
                      },
                    );
                  }
                }
                return const Center(
                    child: CircularProgressIndicator(color: red2));
              }),
            ),
          )),
    );
  }
}

class SurgeryWidget extends StatelessWidget {
  const SurgeryWidget({
    super.key,
    required this.surgery,
  });
  final SurgeryModel surgery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ContainerWidget(
        height: 100,
        width: context.getWidth(divide: 1.15),
        borderColor: noColor,
        borderWidth: 0,
        borderRadius: 20,
        containerColor: white,
        blurRadius: 20,
        shadowColor: const Color.fromARGB(34, 0, 0, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                        '${'surgical_record.surgical_record_name'.tr()} ${surgery.label}',
                  ),
                  TextWidget(
                    text:
                        '${'surgical_record.surgical_record_date'.tr()} ${surgery.date}',
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  final Uri url = Uri.parse(surgery.surgeryReport!);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch report');
                  }
                },
                icon: const Icon(
                  Icons.file_present_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
