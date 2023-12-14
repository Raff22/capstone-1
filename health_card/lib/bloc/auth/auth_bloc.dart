import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/database/supa_add_update/supa_add_update.dart';
import 'package:health_card/database/supa_auth/supa_auth.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/format_checks.dart/format_checks.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStatee> {
  dynamic currentUser;
  bool? currentUserTypeIsPatient;
  AuthBloc() : super(InitialState()) {
    on<UserTypeSelectionEvent>((event, emit) {
      currentUserTypeIsPatient = event.selectPatient;
      emit(UserTypeSelectionUpdateState(
          selectPatient: currentUserTypeIsPatient!));
    });
    on<GetResultsOfSelectionEvent>((event, emit) {
      if (currentUserTypeIsPatient != null) {
        if (currentUserTypeIsPatient!) {
          emit(UserIsPatientState());
        } else {
          emit(UserIsParamedicState());
        }
      }
    });
    on<PatientRegisterationEvent>((event, emit) async {
      currentUser = null;
      if (event.name.isNotEmpty &&
          event.password.isNotEmpty &&
          event.phone.isNotEmpty &&
          event.email.isNotEmpty) {
        if (FormatCheck().checkEmailFormat(event.email)) {
          if (FormatCheck().checkPhone(event.phone)) {
            if (FormatCheck().checkPasswordLength(event.password)) {
              currentUser = Patient(
                  fullName: event.name,
                  email: event.email,
                  phoneNumber: event.phone);
              emit(LoadingState());
              try {
                final response = await SupaAuth()
                    .register(currentUser!.email!, event.password);
                if (response != null) {
                  emit(PatientRegisterationSuccessState());
                }
              } catch (error) {
                emit(ErrorState(message: "error was found", stopLoading: true));
              }
            } else {
              emit(ErrorState(
                  message: 'Patient_regestraion_screen.errorMessage'.tr(),
                  stopLoading: false));
            }
          } else {
            emit(ErrorState(
                message: 'Patient_regestraion_screen.phoneFormatError'.tr(),
                stopLoading: false));
          }
        } else {
          emit(ErrorState(
              message: 'Patient_regestraion_screen.emailFormatError'.tr(),
              stopLoading: false));
        }
      } else {
        emit(ErrorState(
            message: 'Patient_regestraion_screen.validatorMessage'.tr(),
            stopLoading: false));
      }
    });
    on<VerficationEvent>((event, emit) async {
      emit(LoadingState());
      try {
        if (currentUser != null) {
          final response =
              await SupaAuth().verfiyOTP(currentUser!.email!, event.pin);
          print(response);
          if (currentUserTypeIsPatient!) {
            final response2 =
                await SupaAddAndUpdate().addPatientToDatabase(currentUser!);
            print(response2);
          }

          emit(VerficationSuccessState());
        }
      } catch (error) {
        emit(ErrorState(
            message: 'Patient_regestraion_screen.errorMessage'.tr(),
            stopLoading: true));
      }
    });
    on<PatientLoginEvent>((event, emit) async {
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(ErrorState(
            message: 'Patient_regestraion_screen.validatorMessage'.tr(),
            stopLoading: false));
      } else {
        emit(LoadingState());
        // Future.delayed(const Duration(microseconds: 100));
        try {
          await SupaAuth().login(event.email, event.password);
          final Patient currPatient =
              await SupaGetAndDelete().getPatientByEmail(event.email);
          emit(PatientLoginSuccessState(currentPatient: currPatient));
        } catch (error) {
          emit(ErrorState(
              message: 'Patient_login_screen.errorMessage'.tr(),
              stopLoading: true));
        }
      }
    });
    on<ParamedicRegisterationEvent>((event, emit) async {
      currentUser = null;
      if (event.moseefyID.isEmpty) {
        emit(ErrorState(
            message: 'Patient_regestraion_screen.validatorMessage'.tr(),
            stopLoading: false));
      } else {
        emit(LoadingState());
        try {
          print("in bloc");
          final resonse =
              await SupaGetAndDelete().getParamedic(event.moseefyID);
          print(resonse);
          if (resonse == null) {
            emit(ErrorState(
                message: 'ParamedicRegistrationScreen.notfoundmessage'.tr(),
                stopLoading: true));
          } else {
            currentUser = resonse;
            final response2 = await SupaAuth()
                .login(currentUser!.email!, currentUser!.email!);
            print(response2);
            emit(ParamedicRegisterationSuccessState(currUser: resonse));
          }
          print("out bloc");
        } catch (error) {
          emit(ErrorState(
              message: 'Patient_regestraion_screen.errorMessage'.tr(),
              stopLoading: true));
        }
      }
    });
    on<SignOutEvent>((event, emit) async {
      await SupaAuth().signOut();
      emit(SignOutState());
    });
  }
}
