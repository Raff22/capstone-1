abstract class FrontBodyEvent {}

class LoadFrontBodyDataEvent extends FrontBodyEvent {
  final String patientId;

  LoadFrontBodyDataEvent(this.patientId);
}
