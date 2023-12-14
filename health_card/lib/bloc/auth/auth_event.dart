// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class AuthEvent {}

class PatientRegisterationEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  PatientRegisterationEvent(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone});
}

class UserTypeSelectionEvent extends AuthEvent {
  final bool selectPatient;

  UserTypeSelectionEvent({required this.selectPatient});
}

class GetResultsOfSelectionEvent extends AuthEvent {}

class PatientLoginEvent extends AuthEvent {
  final String email;
  final String password;

  PatientLoginEvent({required this.email, required this.password});
}

class ParamedicRegisterationEvent extends AuthEvent {
  String moseefyID;
  ParamedicRegisterationEvent({
    required this.moseefyID,
  });
}

class VerficationEvent extends AuthEvent {
  final String pin;

  VerficationEvent({required this.pin});
}

class SignOutEvent extends AuthEvent {}
