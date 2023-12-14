import 'package:health_card/models/paramedic_model.dart';
import 'package:health_card/models/patient_model.dart';

abstract class AuthStatee {}

class InitialState extends AuthStatee {}

class PatientRegisterationSuccessState extends AuthStatee {}

class PatientLoginSuccessState extends AuthStatee {
  final Patient currentPatient;

  PatientLoginSuccessState({required this.currentPatient});
}

class ParamedicRegisterationSuccessState extends AuthStatee {
  final Paramedic currUser;

  ParamedicRegisterationSuccessState({required this.currUser});
}

class VerficationSuccessState extends AuthStatee {}

class LoadingState extends AuthStatee {}

class ErrorState extends AuthStatee {
  final String message;
  final bool stopLoading;

  ErrorState({required this.message, required this.stopLoading});
}

class UserTypeSelectionUpdateState extends AuthStatee {
  final bool selectPatient;

  UserTypeSelectionUpdateState({required this.selectPatient});
}

class UserIsParamedicState extends AuthStatee {}

class UserIsPatientState extends AuthStatee {}

class SignOutState extends AuthStatee {}
