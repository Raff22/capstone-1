import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/mus3ef_screens/custom_wedgets/front_body_digram_wedget.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/nav_bar.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/back_body_screen.dart';

class FrontBody extends StatefulWidget {
  const FrontBody({super.key, required this.patientId});
  final String patientId;

  @override
  State<FrontBody> createState() => _FrontBodyState();
}

class _FrontBodyState extends State<FrontBody> {
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
      return const Scaffold(
          body: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF64D0F0), Color(0xFF205078)],
                ),
              ),
              child: Center(child: CircularProgressIndicator())));
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
                height: 20,
              ),
              SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 50,
                  width: 420,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BackbodyScreen(
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
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 10, top: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.black),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("disability", style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.red),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("injury", style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
              FrontBodyDiagram(
                patientId: widget.patientId,
              )
            ],
          ),
        ),
      ),
    );
  }
}
