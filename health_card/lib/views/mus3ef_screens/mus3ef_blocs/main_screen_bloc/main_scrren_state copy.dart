import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/insurance_model.dart';
import 'package:health_card/models/patient_model.dart';

abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}

class MainScreenLoading extends MainScreenState {}

class MainScreenLoaded extends MainScreenState {
  final Patient patient;
  final Doctor doctor;
  final PersonalInfo personalInfo;
  final InsuranceModel insurance;

  MainScreenLoaded(
      this.patient, this.doctor, this.personalInfo, this.insurance);
}

class MainScreenError extends MainScreenState {}
