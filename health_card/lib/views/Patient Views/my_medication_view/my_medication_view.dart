// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/medications_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/delete_dialoge.dart';
import 'package:health_card/views/Patient%20Views/my_medication_view/my_medication_view_widget/add_new_medication.dart';

class MyMedicationView extends StatelessWidget {
  MyMedicationView({super.key, required this.patient});
  final Patient? patient;

  TextEditingController medicationUnitController = TextEditingController();
  TextEditingController medicationNameController = TextEditingController();
  TextEditingController medicationTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBarWidget(
            context,
            'my_medication.title_screen'.tr(),
            AddNewMedication(
              medicationUnitController: medicationUnitController,
              medicationNameController: medicationNameController,
              medicationTimeController: medicationTimeController,
              nameLabelText: 'my_medication.name_label_text'.tr(),
              unitLabelText: 'my_medication.unit_label_text'.tr(),
              timeLabelText: 'my_medication.time_label_text'.tr(),
              titleAddInfo: 'my_medication.title_add_info'.tr(),
              onPressed: () {
                context.popScreen();
                if (medicationNameController.text.isNotEmpty &&
                    medicationUnitController.text.isNotEmpty &&
                    medicationTimeController.text.isNotEmpty) {
                  final Medication medication = Medication(
                      medicationName: medicationNameController.text,
                      medicationTime: medicationTimeController.text,
                      dose: medicationUnitController.text,
                      patientId: patient!.id);

                  context.read<PatientBloc>().add(AddPatientMedicationEvent(
                      medication, patient!.id.toString(), patient!));
                } else {
                  return null;
                }

                medicationNameController.clear();
                medicationUnitController.clear();
                medicationTimeController.clear();
              },
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: context.getHeight(),
            width: context.getWidth(),
            child: BlocBuilder<PatientBloc, PatientBlocSatet>(
                builder: (context, state) {
              if (state is SucssessPatientMedicationState) {
                if (state.medication.isEmpty) {
                  return Center(
                      child: TextWidget(
                    text: 'x-rays_reports.suggestion'.tr(),
                    fontSizeText: 20,
                    fontWeightText: FontWeight.w400,
                  ));
                } else if (state.medication.isNotEmpty) {
                  print("list");
                  return ListView.builder(
                    itemCount: state.medication.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        text:
                                            '${'my_medication.my_medication_name'.tr()} ${state.medication[index].medicationName ?? ''}'),
                                    TextWidget(
                                      text:
                                          '${'my_medication.my_medication_units'.tr()}  ${state.medication[index].dose ?? ''}',
                                    ),
                                    TextWidget(
                                      text:
                                          '${'my_medication.my_medication_time'.tr()}  ${state.medication[index].medicationTime ?? ''}',
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteAlert(
                                        context: context,
                                        onPressed: () {
                                          context.read<PatientBloc>().add(
                                              DeletePatientMedicationEvent(
                                                  state.medication[index].id
                                                      .toString(),
                                                  patient!.id!));
                                          Navigator.pop(context);
                                        },
                                        content: state
                                            .medication[index].medicationName!,
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.delete_outline_rounded))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              } else if (state is ErrorPatientaState) {}
              return const Center(
                child: CircularProgressIndicator(
                  color: red2,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
