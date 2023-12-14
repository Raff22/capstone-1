import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/digram_blocs/bloc/digram_state.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/front_digram_blocs/bloc/front_digram_event.dart';

class FrontBodyBloc extends Bloc<FrontBodyEvent, FrontBodyState> {
  final SupaGetAndDelete supaGetAndDelete;

  FrontBodyBloc(this.supaGetAndDelete) : super(FrontBodyInitial()) {
    on<LoadPatientData>(_onLoadPatientData);
  }

  Future<void> _onLoadPatientData(
      LoadPatientData event, Emitter<FrontBodyState> emit) async {
    try {
      emit(FrontBodyLoading());
      var patient = await supaGetAndDelete.getPatientById(event.patientId);
      var mobilityProblems =
          await supaGetAndDelete.getMobilityProblems(patient.id!);
      emit(FrontBodyLoaded(patient, mobilityProblems));
    } catch (e) {
      emit(FrontBodyError(e.toString()));
    }
  }
}
