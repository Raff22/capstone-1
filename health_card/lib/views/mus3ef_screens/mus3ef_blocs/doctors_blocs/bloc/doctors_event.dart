abstract class DoctorViewEvent {}

class LoadDoctorAndPatientData extends DoctorViewEvent {
  final String patientId;

  LoadDoctorAndPatientData(this.patientId);
}
