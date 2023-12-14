import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/database/supa_add_update/supa_add_update.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/database/storage/supa_storage.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/EmergencyContact_model.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/XRay_model.dart';
import 'package:health_card/models/allergies_model.dart';
import 'package:health_card/models/chronic_disease_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/insurance_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/models/surgery_model.dart';
import 'package:health_card/models/medications_model.dart';
import 'package:health_card/utilities/format_checks.dart/format_checks.dart';

class PatientBloc extends Bloc<PatientBlocEvent, PatientBlocSatet> {
  PatientBloc() : super(InitialPatientState()) {
    // on<GetPatientEvent>((event, emit) {
    //   SupaServices().getPatient(email);
    // });

    //------------------- insert patient personal info -------------------------
    on<UploadProfilePictureEvent>((event, emit) async {
      emit(LoadingPatientaState());
      if (profileImage == null || profileImage!.isEmpty) {
        profileImage = await SupaStorage()
            .uploadPatientImage(event.imageFile, event.patient);
        emit(UploadedImageSuccessfulyState());
      } else {
        profileImage = await SupaStorage()
            .updatePatientImage(event.imageFile, event.patient, profileImage!);
        emit(UploadedImageSuccessfulyState());
      }
    });

    //-------------------------------------

    on<UploadXrayReportEvent>((event, emit) async {
      if (event.date.isNotEmpty &&
          event.name.isNotEmpty &&
          event.pdfFile.path.isNotEmpty) {
        emit(LoadingPatientaState());
        final response =
            await SupaStorage().uploadXrayReport(event.pdfFile, event.patient);
        final rsponse2 = SupaAddAndUpdate().addXray(XRay(
            patientId: event.patient.id!,
            label: event.name,
            date: event.date,
            xrayReport: response));
        final List<XRay> l =
            await SupaGetAndDelete().getXray(event.patient.id!);
        emit(UpdateXrayListState(xrayList: l));
      }
    });

    //-------------------------------------

    on<DeleteXrayEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        await SupaGetAndDelete().deletXray(event.xrayId);

        final List<XRay> l = await SupaGetAndDelete().getXray(event.patientId);
        emit(UpdateXrayListState(xrayList: l));
      } catch (e) {
        print(e.toString());
      }
    });

    //-------------------------------------

    on<UploadSurgeryReportEvent>((event, emit) async {
      emit(LoadingPatientaState());
      final response =
          await SupaStorage().uploadSurgery(event.pdfFile, event.patient);
      final rsponse2 = SupaAddAndUpdate().addSergury(SurgeryModel(
          patientId: event.patient.id!,
          label: event.name,
          date: event.date,
          surgeryReport: response));
      final List<SurgeryModel> l =
          await SupaGetAndDelete().getSerguryById(event.patient.id!);
      emit(UpdateSurgeryListState(surgeries: l));
    });

    //-------------------------------------

    on<DeleteSurgeryEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        await SupaGetAndDelete().deletSergury(event.surgeryId);

        final List<SurgeryModel> l =
            await SupaGetAndDelete().getSerguryById(event.patientId);
        emit(UpdateSurgeryListState(surgeries: l));
      } catch (e) {
        emit(ErrorPatientaState(message: "problem with uploading your report"));
      }
    });

    //-------------------------------------

    on<AddPatientInfoEvent>((event, emit) async {
      if (event.personalInfo.nationalId!.isNotEmpty &&
          event.personalInfo.birthday!.isNotEmpty &&
          event.personalInfo.height!.toString().isNotEmpty &&
          event.personalInfo.weight!.toString().isNotEmpty &&
          event.personalInfo.bloodType!.isNotEmpty) {
        emit(LoadingPatientaState());
        if (event.patient.personalInformationId == null) {
          try {
            SupaAddAndUpdate().addPatientPersonalInformation(
                personalInfo: event.personalInfo, patient: event.patient);
            add(GetdataEvent(
              event.patient.id!,
              event.patient,
              'Medical Information',
            ));
          } catch (error) {
            emit(ErrorPatientaState(message: error.toString()));
          }
        } else {
          event.personalInfo.id = event.patient.personalInformationId;
          try {
            SupaAddAndUpdate().updatePatientPersonalInformation(
              personalInfo: event.personalInfo,
            );
            add(GetPatientInfoCardEvent(event.patient));
            add(GetdataEvent(
              event.patient.id!,
              event.patient,
              'Medical Information',
            ));
          } catch (error) {
            emit(ErrorPatientaState(message: error.toString()));
          }
        }
      }
    });

    //--------------------- get patient personal info --------------------------

    on<GetPatientInfoCardEvent>((event, emit) async {
      // print("00000000000000000000000000000000000");

      if (event.patient.personalInformationId != null) {
        final PersonalInfo patientPersonaInfo = await SupaGetAndDelete()
            .getPersonalInformationById(event.patient.personalInformationId!);
        final List<ChronicDisease> chronicDiseaseList =
            await getChronicDisease(event.patient);
        emit(SucssessPatientInfoCardState(
            personalInfo: patientPersonaInfo,
            chronicDisease: chronicDiseaseList));
      } else {
        final List<ChronicDisease> chronicDiseaseList =
            await getChronicDisease(event.patient);
        emit(SucssessPatientInfoCardState(
            personalInfo: PersonalInfo(), chronicDisease: chronicDiseaseList));
      }
    });

    //------------------------ insert emergency contact ------------------------
    on<GetEmergencyContactEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        List<EmergencyContact> contacts =
            await SupaGetAndDelete().getEmergencyContact(event.patient.id!);
        emit(BringContactListState(contacts: contacts));
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    on<AddEmergencyContactEvent>((event, emit) async {
      if (event.emergencyContact.name!.isNotEmpty &&
          event.emergencyContact.phoneNumber!.isNotEmpty &&
          event.emergencyContact.relationshipType!.isNotEmpty) {
        if (!FormatCheck().checkPhone(event.emergencyContact.phoneNumber!)) {
          emit(ErrorPatientaState(
              message: 'Patient_regestraion_screen.phoneFormatError'.tr()));
        }
        emit(LoadingPatientaState());
        try {
          SupaAddAndUpdate().addEmergencyContact(
              emergencyContact: event.emergencyContact, patient: event.patient);
          List<EmergencyContact> contacts =
              await SupaGetAndDelete().getEmergencyContact(event.patient.id!);
          emit(UpdateContactListState(contacts: contacts));
          // emit(UpdateInfoState());
        } catch (error) {
          emit(ErrorPatientaState(message: "error"));
        }
      }
    });

    on<DeleteEmergenceyContact>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        await SupaGetAndDelete().deleteEmergencyContact(event.contactID);
        emit(LoadingPatientaState());
        List<EmergencyContact> contacts =
            await SupaGetAndDelete().getEmergencyContact(event.patientId);
        emit(UpdateContactListState(contacts: contacts));
      } catch (e) {
        emit(ErrorPatientaState(message: "error"));
      }
    });

    //-------------------------- Add Chronic Diseases------------------------------------------------

    on<AddPatientChronicDiseasesEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        SupaAddAndUpdate().addChronicDisease(
          patientId: event.patientID,
          body: event.chronicDisease,
        );

        add(GetdataEvent(
          event.patientID,
          event.patient,
          "Medical Information",
        ));
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    //-------------------------- Add Allergies------------------------------------------------

    on<AddPatientAllergiesEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        SupaAddAndUpdate()
            .addAllergiens(allergies: event.allergies, patient: event.patient);
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    //-------------------------- Add Medical Information ------------------------------------------------

    on<AddPatientMediclaInfoEvent>((event, emit) async {
      print("in add patient medical info bloc");
      emit(LoadingPatientaState());
      try {
        SupaAddAndUpdate()
            .addMedicalInformation(event.medicalInformation, event.patient);

        add(GetdataEvent(
          event.patient.id!,
          event.patient,
          "My Medication",
        ));
        print('has added');
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    //-------------------------- Add Doctor Information ------------------------------------------------

    on<AddPatientDoctorInfoEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        SupaAddAndUpdate().addDoctor(event.doctor, event.patient);

        add(GetdataEvent(
          event.patient.id!,
          event.patient,
          "My Doctor",
        ));
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    //---------------------------- Add Medications -----------------------------

    on<AddPatientMedicationEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        SupaAddAndUpdate().addMedication(event.medication);
        final List<Medication> medicationList =
            await getMedication(event.patientID);
        emit(SucssessPatientMedicationState(medicationList));
        add(GetdataEvent(
          event.patientID,
          event.patient,
          'My Medication',
        ));
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    //---------------------------- Add Mobility Problem --------------------------------

        on<AddPatientMobilityProblemEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
print("4");

      await  SupaAddAndUpdate().addMobilityProblem(event.mobilityProblem);
        final List<MobilityProblem> mobilityProblemList =
            await getMobilityProblem(event.patientID);
print("5");

        emit(SucssessPatientMobilityProblemState(mobilityProblemList));
        add(GetdataEvent(
          event.patientID,
          event.patient,
          'Physical Problem',
          
        ));
print("6");

      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    //---------------------------- Get All Data -----------------------------

    on<GetdataEvent>((event, emit) async {
      //------------------- Get Doctor --------------------

      if (event.type == "My Doctor") {
        print("my doctor");

        final Doctor? doctor = await getDoctorInfo(event.patient.doctorId);
        // print(doctor);
        emit(SucssessPatientDoctorState(doctor));
      }

      //-------------- Get Medical Information ------------

      if (event.type == "Medical Information") {
        final PersonalInfo personalInfo = await getPersonalInfo(event.patient);
        final List<Allergies> allergiesList = await getAllergies(event.patient);
        final List<ChronicDisease> chronicDiseaseList =
            await getChronicDisease(event.patient);
        final MedicalInformation medicalInfo =
            await getMedicalInfo(event.patient);
        print('---------------- prsonal get info ---------------');
        print(personalInfo);
        print(allergiesList);
        print(chronicDiseaseList);
        print(medicalInfo);
        emit(SucssessPatientDataState(personalInfo, chronicDiseaseList,
            allergiesList, event.patient, medicalInfo));

        // add(GetdataEvent(
        //     event.patientID, 'Medical Information', event.patient));
      }
      if (event.type == "Physical Problem") {
        final List<MobilityProblem> mobilityProblemList =
            await getMobilityProblem(event.patientID);
        emit(SucssessPatientMobilityProblemState(mobilityProblemList));
      }
      if (event.type == "Surgical Record") {
        final List<SurgeryModel> l =
            await SupaGetAndDelete().getSerguryById(event.patientID);
        emit(UpdateSurgeryListState(surgeries: l));
      }
      if (event.type == "My Medication") {
        final List<Medication> medicationList =
            await getMedication(event.patientID);
        emit(SucssessPatientMedicationState(medicationList));
      }
      if (event.type == "Laboratory Result") {}
      if (event.type == "XRays Report") {
        print(event.patientID);
        final List<XRay> l = await SupaGetAndDelete().getXray(event.patientID);
        print(l.length);
        emit(UpdateXrayListState(xrayList: l));
      }
    });

    //---------------------------- Delete Medications -----------------------------

    on<DeletePatientMedicationEvent>((event, emit) async {
      try {
        SupaGetAndDelete().deletMedication(event.medicationID);

        final List<Medication> medicationList =
            await getMedication(event.patientID);
        emit(SucssessPatientMedicationState(medicationList));
      } catch (e) {
        print(e.toString());
      }
    });

    //------------------------------ Delete Mobility Problem  ----------------

    on<DeleteMobilityProblemEvent>((event, emit) async {
      try {
        SupaGetAndDelete().deletMobilityProblem(event.mobilityProblemID);

        final List<MobilityProblem> mobilityProblemList =
            await getMobilityProblem(event.patientID);
        emit(SucssessPatientMobilityProblemState(mobilityProblemList));
      } catch (e) {
        print(e.toString());
      }
    });

    //------------------------- Update Doctor Info -----------------------------

    on<UpdateDoctorInfoEvent>((event, emit) {
      try {
        SupaAddAndUpdate().updateDoctor(event.doctor);
        add(GetdataEvent(
          event.patient.id!,
          event.patient,
          "My Doctor",
        ));
      } catch (e) {
        print(e.toString());
      }
    });

    // ------------------------ Update Medical Information Info -----------------------------

    on<UpdatePatientMedicalInfoInfoEvent>((event, emit) {
      try {
        SupaAddAndUpdate().updateMedicalInformation(event.medicalInformation);
      } catch (e) {
        print('rrrrrr ${e.toString()}');
      }
    });

    //-------------------------- Add Insurance Information ------------------------------------------------

    on<AddPatientInsuranceInfoEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        SupaAddAndUpdate().addInsurance(event.insurance, event.patient);

        print('has added');
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    on<GetInsuranceEvent>((event, emit) async {
      try {
        final InsuranceModel insuranceModel =
            await SupaGetAndDelete().getInsurance(event.patient.insuranceId!);

        print(insuranceModel.companyName);
        emit(GetInsuranceState(insuranceModel: insuranceModel));
      } catch (error) {
        emit(ErrorPatientaState(message: error.toString()));
      }
    });

    // ------------------------ Update Insurance Info -----------------------------

    on<UpdateInsuranceEvent>((event, emit) async {
      emit(LoadingPatientaState());
      try {
        SupaAddAndUpdate().updateInsurance(event.insurance, event.insuranceId);
        add(GetdataEvent(event.patient.id!, event.patient, ''));
      } catch (e) {
        print(e.toString());
      }
    });

    //---------------------------- Delete Chronic Disease -----------------------------

    on<DeleteChronicDiseaseEvent>((event, emit) async {
      try {
        SupaGetAndDelete().deleteChronicDisease(
          event.patientId,
          event.chronicDiseaseId,
        );
        add(GetdataEvent(
          event.patientId,
          event.patient,
          "Medical Information",
        ));
      } catch (e) {
        print(e.toString());
      }
    });
    on<DeleteAllergiesEvent>((event, emit) async {
      try {
        SupaGetAndDelete().deleteAllergies(event.allergiesID);
        add(GetdataEvent(
          event.patientId,
          event.patient,
          "Medical Information",
        ));
      } catch (e) {
        print(e.toString());
      }
    });
  }

  Future<List<Medication>> getMedication(String patientID) async {
    final List<Medication> medicationList =
        await SupaGetAndDelete().getMedications(patientID);
    print('here the list od medication');
    print(medicationList);

    return medicationList;
  }

  Future<List<MobilityProblem>> getMobilityProblem(String patientID) async {
    final List<MobilityProblem> mobilityProblemList =
        await SupaGetAndDelete().getMobilityProblems(patientID);
    print('here the list  mobilityProblemList');
    print(mobilityProblemList);

    return mobilityProblemList;
  }

  Future<Doctor?> getDoctorInfo(String? doctorID) async {
    if (doctorID != null) {
      final Doctor doctor = await SupaGetAndDelete().getDoctorById(doctorID);
      return doctor;
    } else {
      return null;
    }
  }

  Future<MedicalInformation> getMedicalInfo(Patient patient) async {
    if (patient.medicalInformationId == null) {
      return MedicalInformation();
    } else {
      final MedicalInformation medicalInfo = await SupaGetAndDelete()
          .getMedicalInformation(patient.medicalInformationId!);
      return medicalInfo;
    }
  }

  Future<PersonalInfo> getPersonalInfo(Patient patient) async {
    final PersonalInfo patientPersonaInfo = await SupaGetAndDelete()
        .getPersonalInformationById(patient.personalInformationId!);
    return patientPersonaInfo;
  }

  Future<List<Allergies>> getAllergies(Patient patient) async {
    final List<Allergies> allergiesList =
        await SupaGetAndDelete().getAllergies(patient.id!);
    return allergiesList;
  }

  Future<List<ChronicDisease>> getChronicDisease(Patient patient) async {
    final List<ChronicDisease> chronicDiseaseList =
        await SupaGetAndDelete().getChronicDiseases(patient.id!);
    return chronicDiseaseList;
  }
}
