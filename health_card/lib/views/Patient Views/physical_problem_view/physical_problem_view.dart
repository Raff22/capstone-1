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
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/delete_dialoge.dart';
import 'package:health_card/views/Patient%20Views/physical_problem_view/physical_problem_view_widget/add_new_mobility_problem.dart';

String? mobilityType;
String? mobilityPlace;

class PhysicalProblemView extends StatelessWidget {
  PhysicalProblemView({super.key, this.patient});
  final Patient? patient;

  TextEditingController problemNameController = TextEditingController();
  TextEditingController problemDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context,
          'physical_proplem.title_screen'.tr(),
          AddNewMobilityProblem(
              problemNameController: problemNameController,
              problemDescriptionController: problemDescriptionController,
              titleAddInfo: 'physical_proplem.title_add_info'.tr(),
              nameLabelText: 'physical_proplem.name_label_text'.tr(),
              mobilityType: mobilityType,
              mobilityPlace: mobilityPlace,
              patient: patient,
              onPressed: () {
                // context.popScreen();
                // print("1");
                // print(problemNameController.text);
                // print(mobilityType);
                // print(mobilityPlace);
                // if (problemNameController.text.isNotEmpty &&
                //     mobilityType != null &&
                //     mobilityPlace != null) {
                //   print("2");

                //   final MobilityProblem mobilityProblem = MobilityProblem(
                //       problemName: problemNameController.text,
                //       problemType: mobilityType,
                //       problemPlace: mobilityPlace,
                //       patientId: patient!.id);
                //   print("3");

                //   context.read<PatientBloc>().add(
                //       AddPatientMobilityProblemEvent(
                //           mobilityProblem, patient!.id.toString(), patient!));
                // } else {
                //   return null;
                // }
                // problemNameController.clear();
                // return showDialog(
                //   context: context,
                //   builder: (BuildContext context) => AlertDialog(
                //     title: TextWidget(
                //         text: 'Patient_regestraion_screen.validatorMessage2'
                //             .tr()),
                //     actions: <Widget>[
                //       TextButton(
                //         onPressed: () => Navigator.pop(context),
                //         child: Center(
                //             child: TextWidget(
                //           text: 'my_doctor_view.OK'.tr(),
                //           colorText: red2,
                //         )),
                //       ),
                //     ],
                //   ),
                // );
              })),
      body: SizedBox(
        height: context.getHeight(),
        width: context.getWidth(),
        child: BlocBuilder<PatientBloc, PatientBlocSatet>(
          builder: (context, state) {
            if (state is SucssessPatientMobilityProblemState) {
              if (state.mobilityProblem.isEmpty) {
                return Center(
                    child: TextWidget(
                  text: 'x-rays_reports.suggestion'.tr(),
                  fontSizeText: 20,
                  fontWeightText: FontWeight.w400,
                ));
              } else if (state.mobilityProblem.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.mobilityProblem.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          children: [
                            ContainerWidget(
                              width: context.getWidth(divide: 1.15),
                              borderColor: noColor,
                              borderWidth: 0,
                              borderRadius: 20,
                              containerColor: white,
                              blurRadius: 20,
                              shadowColor: const Color.fromARGB(34, 0, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: context.getWidth(divide: 1.80),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text:
                                                '${'physical_proplem.physical_proplem_name'.tr()} ${state.mobilityProblem[index].problemName}',
                                          ),
                                          TextWidget(
                                            text:
                                                '${'physical_proplem.physical_proplem_type'.tr()} ${state.mobilityProblem[index].problemType}',
                                          ),
                                          TextWidget(
                                            text:
                                                '${'physical_proplem.physical_proplem_place'.tr()} ${state.mobilityProblem[index].problemPlace}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          deleteAlert(
                                            context: context,
                                            onPressed: () {
                                              context.read<PatientBloc>().add(
                                                  DeleteMobilityProblemEvent(
                                                      state
                                                          .mobilityProblem[
                                                              index]
                                                          .id
                                                          .toString(),
                                                      patient!.id!));
                                              Navigator.pop(context);
                                            },
                                            content: state
                                                .mobilityProblem[index]
                                                .problemName!,
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.delete_outline_rounded))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
            } else if (state is ErrorPatientaState) {}
            return const Center(
              child: CircularProgressIndicator(
                color: red2,
              ),
            );
          },
        ),
      ),
    );
  }
}
