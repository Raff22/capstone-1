import 'package:flutter/material.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class BackBodyDigram extends StatefulWidget {
  const BackBodyDigram({
    super.key,
    required this.patientId,
  });
  final String patientId;

  @override
  State<BackBodyDigram> createState() => _BackBodyDigramState();
}

class _BackBodyDigramState extends State<BackBodyDigram> {
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
      return const Center(child: CircularProgressIndicator());
    }

    placeList =
        currentMobilityProblem.map((problem) => problem.toMap()).toList();

    return Stack(
      children: [
        SizedBox(
            width: context.getWidth(divide: 1),
            height: 600,
            child: Image.asset("assets/images/backbody.png")),
        buildBodyPartWidget("Left Hand", 300, 90),
        buildBodyPartWidget("Right Hand", 300, 265),
        buildBodyPartWidget("Head", 10, 180),
        buildBodyPartWidget("Right Leg", 530, 200),
        buildBodyPartWidget("Left Leg", 550, 150),
        buildBodyPartWidget("Left Knee", 400, 156),
        buildBodyPartWidget("Right Knee", 400, 205),
        buildBodyPartWidget("Right Elbow", 200, 250),
        buildBodyPartWidget("Left Elbow", 200, 110),
        buildBodyPartWidget("Spine", 170, 180),
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
                  title:
                      Text(problemDetails['problem_placement'] ?? "No Problem"),
                  content: Text(problemDetails['problem_name'] ?? "No issues"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
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
  const DamagePlace({
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
