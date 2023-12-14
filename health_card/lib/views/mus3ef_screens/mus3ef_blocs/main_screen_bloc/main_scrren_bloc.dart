import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/insurance_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/main_screen_bloc/main_scrren_event.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/main_screen_bloc/main_scrren_state%20copy.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final SupaGetAndDelete supaGetAndDelete;

  MainScreenBloc(this.supaGetAndDelete) : super(MainScreenInitial()) {
    on<LoadPatientDataEvent>(_onLoadPatientData);
  }

  Future<void> _onLoadPatientData(
      LoadPatientDataEvent event, Emitter<MainScreenState> emit) async {
    PersonalInfo info = PersonalInfo();
    try {
      emit(MainScreenLoading());
      Patient patient = await supaGetAndDelete.getPatientById(event.patientId);
      if (patient.personalInformationId != null) {
        info = await supaGetAndDelete
            .getPersonalInformationById(patient.personalInformationId!);
      }
      Doctor doctor = patient.doctorId != null
          ? await supaGetAndDelete.getDoctorById(patient.doctorId!)
          : Doctor();
      InsuranceModel insurance = patient.insuranceId != null
          ? await supaGetAndDelete.getInsurance(patient.insuranceId!)
          : InsuranceModel();
      print(patient.insuranceId);
      emit(MainScreenLoaded(patient, doctor, info, insurance));
    } catch (error) {
      print(error.toString());

      emit(MainScreenError());
    }
  }
}
