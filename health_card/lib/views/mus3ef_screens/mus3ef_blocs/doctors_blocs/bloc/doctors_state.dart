import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/patient_model.dart';

abstract class DoctorViewState {}

class DoctorViewInitial extends DoctorViewState {}

class DoctorViewLoading extends DoctorViewState {}

class DoctorViewLoaded extends DoctorViewState {
  final Patient? patient;
  final Doctor? doctor;

  DoctorViewLoaded({this.patient, this.doctor});
}

class DoctorViewError extends DoctorViewState {
  final String message;

  DoctorViewError(this.message);
}
