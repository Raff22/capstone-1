abstract class MainScreenEvent {}

class LoadPatientDataEvent extends MainScreenEvent {
  final String patientId;

  LoadPatientDataEvent(this.patientId);
}
