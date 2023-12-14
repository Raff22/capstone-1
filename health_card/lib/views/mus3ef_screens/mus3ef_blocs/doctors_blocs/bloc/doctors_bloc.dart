import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/doctors_blocs/bloc/doctors_event.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/doctors_blocs/bloc/doctors_state.dart';

class DoctorViewBloc extends Bloc<DoctorViewEvent, DoctorViewState> {
  final SupaGetAndDelete supaGetAndDelete;

  DoctorViewBloc({required this.supaGetAndDelete})
      : super(DoctorViewInitial()) {
    on<LoadDoctorAndPatientData>(_onLoadDoctorAndPatientData);
  }

  Future<void> _onLoadDoctorAndPatientData(
    LoadDoctorAndPatientData event,
    Emitter<DoctorViewState> emit,
  ) async {
    emit(DoctorViewLoading());
    try {
      var patient = await supaGetAndDelete.getPatientById(event.patientId);
      Doctor? doctor = patient != null && patient.doctorId != null
          ? await supaGetAndDelete.getDoctorById(patient.doctorId!)
          : null;
      emit(DoctorViewLoaded(patient: patient, doctor: doctor));
    } catch (error) {
      emit(DoctorViewError(error.toString()));
    }
  }
}
