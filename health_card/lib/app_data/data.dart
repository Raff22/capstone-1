import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/views/Patient%20Views/laboratory_result_view/laboratory_result_view.dart';
import 'package:health_card/views/Patient%20Views/medical_information_view/medical_information_view.dart';
import 'package:health_card/views/Patient%20Views/physical_problem_view/physical_problem_view.dart';
import 'package:health_card/views/Patient%20Views/my_medication_view/my_medication_view.dart';
import 'package:health_card/views/Patient%20Views/my_doctor_view/my_doctor_view.dart';
import 'package:health_card/views/Patient%20Views/surgical_record_view/surgical_record_view.dart';
import 'package:health_card/views/Patient%20Views/x-rays_reports_view/x-rays_reports_view.dart';

List home = [
  {
    "type": "My Doctor",
    "view": MyDoctorView(
      patient: globalCurrentPatient,
    ),
    "image": 'assets/images/my_doctor.png',
    "title": 'patient_home_screen.first_container'.tr(),
  },
  {
    "type": "Medical Information",
    "view": const MedicalInformationView(),
    "image": 'assets/images/medical_information.png',
    "title": 'patient_home_screen.second_container'.tr(),
  },
  {
    "type": "Physical Problem",
    "view": PhysicalProblemView(
      patient: globalCurrentPatient,
    ),
    "image": 'assets/images/physical_problem.png',
    "title": 'patient_home_screen.third_container'.tr(),
  },
  {
    "type": "Surgical Record",
    "view": SurgicalRecordView(),
    "image": 'assets/images/surgical_record.png',
    "title": 'patient_home_screen.fourth_container'.tr(),
  },
  {
    "type": "My Medication",
    "view": MyMedicationView(
      patient: globalCurrentPatient,
    ),
    "image": 'assets/images/my_medications.png',
    "title": 'patient_home_screen.fifth_container'.tr(),
  },
  {
    "type": "XRays Report",
    "view": XRaysReportsView(),
    "image": 'assets/images/x-rays_reports.png',
    "title": 'patient_home_screen.seventh_container'.tr(),
  },
  {
    "type": "Laboratory Result",
    "view": LaboratoryResult(),
    "image": 'assets/images/laboratory_results.png',
    "title": 'patient_home_screen.sixth_container'.tr(),
  },
];

List<DropdownMenuItem<String>> get physicalProblrmType {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "injury",
        child: Text('dropDownPhysicalProblrmType.value1'.tr())),
    DropdownMenuItem(
        value: "disability",
        child: Text('dropDownPhysicalProblrmType.value2'.tr())),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get placementIssue {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "Heart", child: Text('dropDownPlacementIssue.value1'.tr())),
    DropdownMenuItem(
        value: "Head", child: Text('dropDownPlacementIssue.value2'.tr())),
    DropdownMenuItem(
        value: "Left Hand", child: Text('dropDownPlacementIssue.value3'.tr())),
    DropdownMenuItem(
        value: "Right Hand", child: Text('dropDownPlacementIssue.value4'.tr())),
    DropdownMenuItem(
        value: "Left Leg", child: Text('dropDownPlacementIssue.value5'.tr())),
    DropdownMenuItem(
        value: "Right Leg", child: Text('dropDownPlacementIssue.value6'.tr())),
    DropdownMenuItem(
        value: "Left Knee", child: Text('dropDownPlacementIssue.value7'.tr())),
    DropdownMenuItem(
        value: "Right Knee", child: Text('dropDownPlacementIssue.value8'.tr())),
    DropdownMenuItem(
        value: "Left Elbow", child: Text('dropDownPlacementIssue.value8'.tr())),
    DropdownMenuItem(
        value: "Right Elbow",
        child: Text('dropDownPlacementIssue.value10'.tr())),
    DropdownMenuItem(
        value: "Spine", child: Text('dropDownPlacementIssue.value11'.tr())),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get bloodType {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "A+", child: Text("A+")),
    const DropdownMenuItem(value: "A-", child: Text("A-")),
    const DropdownMenuItem(value: "O+", child: Text("O+")),
    const DropdownMenuItem(value: "O-", child: Text("O-")),
    const DropdownMenuItem(value: "B+", child: Text("B+")),
    const DropdownMenuItem(value: "B-", child: Text("B-")),
    const DropdownMenuItem(value: "AB+", child: Text("AB+")),
    const DropdownMenuItem(value: "AB-", child: Text("AB-")),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get insuranceStatus {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "Active", child: Text('dropDownInsuranceStatus.value1'.tr())),
    DropdownMenuItem(
        value: "Not Active",
        child: Text('dropDownInsuranceStatus.value2'.tr())),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get isSmookerStatus {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Yes", child: Text('Yes')),
    const DropdownMenuItem(value: "No", child: Text('No')),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get relationshipToPatient {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "Parent",
        child: Text('dropDownRelationshipToPatient.value1'.tr())),
    DropdownMenuItem(
        value: "Relative",
        child: Text('dropDownRelationshipToPatient.value2'.tr())),
    DropdownMenuItem(
        value: "Friend",
        child: Text('dropDownRelationshipToPatient.value3'.tr())),
  ];
  return menuItems;
}
