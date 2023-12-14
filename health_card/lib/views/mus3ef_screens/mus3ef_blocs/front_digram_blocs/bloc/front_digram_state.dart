import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/patient_model.dart';

abstract class FrontBodyState {}

class FrontBodyInitial extends FrontBodyState {}

class FrontBodyLoading extends FrontBodyState {}

class FrontBodyLoaded extends FrontBodyState {
  final Patient patient;
  final List<MobilityProblem> mobilityProblems;
  FrontBodyLoaded(this.patient, this.mobilityProblems);
}

class FrontBodyError extends FrontBodyState {
  final String message;
  FrontBodyError(this.message);
}
