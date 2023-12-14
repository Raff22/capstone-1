// ignore_for_file: must_be_immutable, camel_case_types

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/add_new_info_model_sheet_widget.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/XRay_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/delete_dialoge.dart';
import 'package:url_launcher/url_launcher.dart';

class XRaysReportsView extends StatelessWidget {
  XRaysReportsView({super.key});

  TextEditingController xrayDateController = TextEditingController();
  TextEditingController xrayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context,
        'x-rays_reports.title_screen'.tr(),
        AddNewInfoModelSheetWidget(
          prosessDateController: xrayDateController,
          prosessNameController: xrayNameController,
          titleAddInfo: 'x-rays_reports.title_add_info'.tr(),
          nameLabelText: 'x-rays_reports.name_label_text'.tr(),
          dateLabelText: 'x-rays_reports.date_label_text'.tr(),
          onPressed: () {
            print(xrayNameController);
            print(xrayDateController);
          },
          type: 'xray_reports',
        ),
      ),
      body: SizedBox(
        height: context.getHeight(),
        width: context.getWidth(),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: BlocBuilder<PatientBloc, PatientBlocSatet>(
              builder: (context, state) {
                if (state is ErrorPatientaState) {
                  return Center(child: Text(state.message));
                }
                if (state is UpdateXrayListState) {
                  if (state.xrayList.isEmpty) {
                    print("here");
                    return Center(
                        child: TextWidget(
                      text: 'x-rays_reports.suggestion'.tr(),
                      fontSizeText: 20,
                      fontWeightText: FontWeight.w500,
                    ));
                  } else {
                    return ListView.builder(
                      itemCount: state.xrayList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: const Key("index"),
                          confirmDismiss: (direction) async {
                            final x = await deleteAlert(
                                context: context,
                                content: state.xrayList[index].label!,
                                onPressed: () {
                                  context.read<PatientBloc>().add(
                                      DeleteXrayEvent(
                                          xrayId: state.xrayList[index].id!,
                                          patientId:
                                              globalCurrentPatient!.id!));
                                  context.popScreen();
                                });
                            return Future.value(x == 'cancel');
                          },
                          child: XrayWidget(
                            xray: state.xrayList[index],
                          ),
                        );
                      },
                    );
                  }
                }
                return const Center(
                    child: CircularProgressIndicator(color: red2));
              },
            )),
      ),
    );
  }
}

class XrayWidget extends StatelessWidget {
  const XrayWidget({
    super.key,
    required this.xray,
  });
  final XRay xray;

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
                        '${'x-rays_reports.x-rays_reports_name'.tr()} ${xray.label}',
                  ),
                  TextWidget(
                    text:
                        '${'x-rays_reports.x-rays_reports_date'.tr()} ${xray.date}',
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  final Uri url = Uri.parse(xray.xrayReport!);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch report');
                  }
                },
                icon: const Icon(
                  Icons.file_present_rounded,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
