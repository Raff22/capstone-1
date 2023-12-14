import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/chronic_disease_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class ChronicDiseaseContainer extends StatelessWidget {
  const ChronicDiseaseContainer({super.key, this.chronicDisease, this.patient});

  final List<ChronicDisease>? chronicDisease;
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ContainerWidget(
        width: context.getWidth(divide: 1.15),
        borderColor: noColor,
        borderWidth: 0,
        borderRadius: 20,
        containerColor: white,
        blurRadius: 10,
        shadowColor: const Color.fromARGB(34, 0, 0, 0),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListView.builder(
              itemCount: chronicDisease!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (chronicDisease!.isEmpty) {
                  return const Center(
                      child: TextWidget(text: 'No Chronic Disease'));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: '- ${chronicDisease![index].disease}',
                          ),
                          IconButton(
                              onPressed: () {
                               
                                context.read<PatientBloc>().add(
                                    DeleteChronicDiseaseEvent(
                                        chronicDisease![index].id!,
                                        patient!.id!,
                                        patient!));
                              },
                              icon: Icon(Icons.remove))
                        ],
                      ),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }
}
