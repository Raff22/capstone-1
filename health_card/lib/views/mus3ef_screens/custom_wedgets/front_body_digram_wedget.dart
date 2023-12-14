import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class FrontBodyDiagram extends StatefulWidget {
  const FrontBodyDiagram({
    super.key,
    required this.patientId,
  });
  final String patientId;

  @override
  State<FrontBodyDiagram> createState() => _FrontBodyDiagramState();
}

class _FrontBodyDiagramState extends State<FrontBodyDiagram> {
  Patient? currentPatient;
  List<MobilityProblem> currentMobilityProblem = [];
  List<dynamic> placeList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPatientAndMobilityData();
  }

  Future<void> loadPatientAndMobilityData() async {
    try {
      var patient = await SupaGetAndDelete().getPatientById(widget.patientId);
      if (patient != null) {
        currentMobilityProblem =
            await SupaGetAndDelete().getMobilityProblems(patient.id!);
      }
      setState(() {
        currentPatient = patient;
        isLoading = false;
      });
    } catch (error) {
      setState(() => isLoading = false);
      print('Error loading data: $error');
    }
  }

  Color determineColor(String problemType) {
    switch (problemType) {
      case 'injury':
        return Colors.red.withOpacity(0.7); // Red for injury
      case 'disability':
        return Colors.black.withOpacity(0.8); // Black for disability
      default:
        return Colors
            .grey; // Default color if no problem or unknown problem type
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    placeList =
        currentMobilityProblem.map((problem) => problem.toMap()).toList();

    return Stack(
      children: [
        Container(
            width: context.getWidth(divide: 1),
            height: 600,
            child: Image.asset("assets/images/frontbody.png")),
        buildBodyPartWidget("Right Hand", 300, 85),
        buildBodyPartWidget("Left Hand", 300, 270),
        buildBodyPartWidget("Heart", 120, 205),
        buildBodyPartWidget("Head", 10, 180),
        buildBodyPartWidget("Left Leg", 550, 200),
        buildBodyPartWidget("Right Leg", 550, 150),
        buildBodyPartWidget("Right Knee", 400, 156),
        buildBodyPartWidget("Left Knee", 400, 205),
        buildBodyPartWidget("Left Elbow", 200, 250),
        buildBodyPartWidget("Right Elbow", 200, 110),
      ],
    );
  }

  Widget buildBodyPartWidget(String bodyPart, double top, double left) {
    var problemDetails = placeList.firstWhere(
        (problem) => problem['problem_placement'] == bodyPart,
        orElse: () => {'problem_type': '', 'problem_name': ''});

    return Positioned(
      top: top,
      left: left,
      child: Visibility(
        visible: problemDetails['problem_type'].isNotEmpty,
        child: DamagePlace(
            color: determineColor(problemDetails['problem_type']),
            placeHint: bodyPart.toLowerCase(),
            func1: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    problemDetails['problem_placement'] ?? "No Problem",
                    style: TextStyle(fontSize: 30, color: red2),
                  ),
                  content: Text(
                    problemDetails['problem_name'] ?? "No issues",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text(''),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text(''),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class DamagePlace extends StatelessWidget {
  DamagePlace({
    super.key,
    required this.func1,
    required this.placeHint,
    this.color,
  });

  final Function func1;
  final String placeHint;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 8;
    double height = MediaQuery.of(context).size.height / 17;

    return InkWell(
      onTap: () {
        func1();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          color: color ?? Colors.black,
        ),
      ),
    );
  }
}
