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

abstract class PatientBlocSatet {}

class InitialPatientState extends PatientBlocSatet {}

class LoadingPatientaState extends PatientBlocSatet {}

class ErrorPatientaState extends PatientBlocSatet {
  String message;

  ErrorPatientaState({required this.message});
}

class ErrorPatientaState2 extends PatientBlocSatet {
  String message;

  ErrorPatientaState2({required this.message});
}

class SucssessPatientInfoCardState extends PatientBlocSatet {
  final PersonalInfo personalInfo;
  final List<ChronicDisease> chronicDisease;

  SucssessPatientInfoCardState(
      {required this.personalInfo, required this.chronicDisease});
}

class SucssessPatientInfoCardpersonalInfoState extends PatientBlocSatet {
  final PersonalInfo personalInfo;

  SucssessPatientInfoCardpersonalInfoState(this.personalInfo);
}

class SucssessPatientDataState extends PatientBlocSatet {
  final Patient patient;
  final PersonalInfo personalInfo;
  final List<ChronicDisease> chronicDisease;
  final List<Allergies> allergies;
  final MedicalInformation medicalInformation;

  SucssessPatientDataState(this.personalInfo, this.chronicDisease,
      this.allergies, this.patient, this.medicalInformation);
}

class SucssessPatientMedicationState extends PatientBlocSatet {
  final List<Medication> medication;

  SucssessPatientMedicationState(this.medication);
}

class SucssessPatientMobilityProblemState extends PatientBlocSatet {
  final List<MobilityProblem> mobilityProblem;

  SucssessPatientMobilityProblemState(this.mobilityProblem);
}

class BringContactListState extends PatientBlocSatet {
  final List<EmergencyContact> contacts;

  BringContactListState({required this.contacts});
}

class UpdateContactListState extends PatientBlocSatet {
  final List<EmergencyContact> contacts;

  UpdateContactListState({required this.contacts});
}

class SucssessPatientDoctorState extends PatientBlocSatet {
  final Doctor? doctor;

  SucssessPatientDoctorState(this.doctor);
}

class NoDoctorInfoSate extends PatientBlocSatet {}

class UploadedMedicalInfoSuccessfulyState extends PatientBlocSatet {}

class UpdateInfoState extends PatientBlocSatet {}

class UploadedImageSuccessfulyState extends PatientBlocSatet {}

class UploadedXraySuccessfulyState extends PatientBlocSatet {}

class UploadedSurgerySuccessfulyState extends PatientBlocSatet {}

class UpdateSurgeryListState extends PatientBlocSatet {
  final List<SurgeryModel> surgeries;

  UpdateSurgeryListState({required this.surgeries});
}

class UpdateXrayListState extends PatientBlocSatet {
  final List<XRay> xrayList;

  UpdateXrayListState({required this.xrayList});
}

class GetInsuranceState extends PatientBlocSatet {
  final InsuranceModel? insuranceModel;

  GetInsuranceState({ this.insuranceModel});
}
