import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/mus3ef_screens/custom_wedgets/back_digram_costom.dart';
import 'package:health_card/views/mus3ef_screens/custom_wedgets/front_body_digram_wedget.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/nav_bar.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/back_body_screen.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/front_body_screen.dart';

class BackbodyScreen extends StatefulWidget {
  const BackbodyScreen({super.key, required this.patientId});
  final String patientId;

  @override
  State<BackbodyScreen> createState() => _BackbodyScreenState();
}

class _BackbodyScreenState extends State<BackbodyScreen> {
  Patient? currentPatient;
  Doctor? currentDoctor;
  MedicalInformation? currentMedications;
  List<MobilityProblem> currentMobilityProblem = [];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadPatientAndMobilityData();
  }

  Future<void> loadPatientAndMobilityData() async {
    try {
      // Load patient data
      var patient = await SupaGetAndDelete()
          .getPatientById(widget.patientId); // Replace with actual patient ID
      MobilityProblem? mobilty;
      MedicalInformation? medcation;
      if (patient != null) {
        // Load doctor data
        currentMobilityProblem =
            await SupaGetAndDelete().getMobilityProblems(patient.id!);
        // print(patient.medical_information_id!);
      }
      // Call setState to update the UI
      setState(() {
        currentPatient = patient;

        currentMedications = medcation;
        if (currentMobilityProblem.isNotEmpty) {
          mobilty = currentMobilityProblem[0];
          isLoading = false;
        }
      });
    } catch (error) {
      setState(() => isLoading = false);
      // Handle any errors here, such as showing a dialog or a snackbar
      print('Error loading data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF64D0F0), Color(0xFF205078)],
            ),
          ),
          child: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      extendBody: true,
      body: Container(
        width: context.getWidth(divide: 1),
        height: context.getHeight(divide: 1),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF64D0F0), Color(0xFF205078)],
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              height20,
              SizedBox(
                height: 50,
                width: 420,
                child: BodyAppBar(widget: widget),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackBodyDigram(
                    patientId: widget.patientId,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BodyAppBar extends StatelessWidget {
  const BodyAppBar({
    super.key,
    required this.widget,
  });

  final BackbodyScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FrontBody(
                            patientId: widget.patientId,
                          )));
            },
            icon: const Icon(Icons.change_circle, size: 40)),
        Text(
          'main_screen.toptitle'.tr(),
          style: const TextStyle(fontSize: 30),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavBar(
                            idText: widget.patientId,
                          )));
            },
            icon: const Icon(
              Icons.home,
              size: 40,
            )),
      ],
    );
  }
}
