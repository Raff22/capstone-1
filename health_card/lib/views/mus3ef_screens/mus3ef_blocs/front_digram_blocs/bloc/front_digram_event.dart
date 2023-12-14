abstract class FrontBodyEvent {}

class LoadPatientData extends FrontBodyEvent {
  final String patientId;
  LoadPatientData(this.patientId);
}
