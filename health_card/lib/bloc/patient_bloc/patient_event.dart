import 'dart:io';

import 'package:health_card/models/EmergencyContact_model.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/allergies_model.dart';
import 'package:health_card/models/chronic_disease_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/insurance_model.dart';
import 'package:health_card/models/medications_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/views/mus3ef_screens/custom_wedgets/main_screen_coustom_wedget.dart';

abstract class PatientBlocEvent {}

class GetPatientEvent extends PatientBlocEvent {
  final String datePicker;

  GetPatientEvent(this.datePicker);
}

class AddPatientInfoEvent extends PatientBlocEvent {
  final Patient patient;
  final PersonalInfo personalInfo;

  AddPatientInfoEvent(this.personalInfo, this.patient);
}

class GetPatientInfoCardEvent extends PatientBlocEvent {
  final Patient patient;

  GetPatientInfoCardEvent(this.patient);
}

class GetEmergencyContactEvent extends PatientBlocEvent {
  final Patient patient;

  GetEmergencyContactEvent({required this.patient});
}

class DeleteEmergenceyContact extends PatientBlocEvent {
  final String contactID;
  final String patientId;

  DeleteEmergenceyContact({required this.contactID, required this.patientId});
}

class AddEmergencyContactEvent extends PatientBlocEvent {
  final Patient patient;
  final EmergencyContact emergencyContact;

  AddEmergencyContactEvent(this.emergencyContact, this.patient);
}

class AddPatientChronicDiseasesEvent extends PatientBlocEvent {
  final ChronicDisease chronicDisease;
  final String patientID;
  final Patient patient;

  AddPatientChronicDiseasesEvent(
      this.chronicDisease, this.patientID, this.patient);
}

class AddPatientAllergiesEvent extends PatientBlocEvent {
  final Allergies allergies;
  final Patient patient;

  AddPatientAllergiesEvent(this.allergies, this.patient);
}

class AddPatientMediclaInfoEvent extends PatientBlocEvent {
  final MedicalInformation medicalInformation;
  final Patient patient;

  AddPatientMediclaInfoEvent(this.medicalInformation, this.patient);
}

class AddPatientDoctorInfoEvent extends PatientBlocEvent {
  final Doctor doctor;
  final Patient patient;

  AddPatientDoctorInfoEvent(this.doctor, this.patient);
}

class AddPatientInsuranceInfoEvent extends PatientBlocEvent {
  final InsuranceModel insurance;
  final Patient patient;

  AddPatientInsuranceInfoEvent(this.insurance, this.patient);
}

class AddPatientMedicationEvent extends PatientBlocEvent {
  final Medication medication;
  final String patientID;
  final Patient patient;

  AddPatientMedicationEvent(this.medication, this.patientID, this.patient);
}

class AddPatientMobilityProblemEvent extends PatientBlocEvent {
  final MobilityProblem mobilityProblem;
  final String patientID;
  final Patient patient;

  AddPatientMobilityProblemEvent(this.mobilityProblem, this.patientID, this.patient);
}

class UploadProfilePictureEvent extends PatientBlocEvent {
  final File imageFile;
  final Patient patient;

  UploadProfilePictureEvent({required this.imageFile, required this.patient});
}

class UploadXrayReportEvent extends PatientBlocEvent {
  final File pdfFile;
  final Patient patient;
  final String name;
  final String date;

  UploadXrayReportEvent(
      {required this.pdfFile,
      required this.patient,
      required this.name,
      required this.date});
}

class UploadSurgeryReportEvent extends PatientBlocEvent {
  final File pdfFile;
  final Patient patient;
  final String name;
  final String date;

  UploadSurgeryReportEvent(
      {required this.pdfFile,
      required this.patient,
      required this.name,
      required this.date});
}

class GetxraysEvent extends PatientBlocEvent {
  final String patientId;

  GetxraysEvent({required this.patientId});
}

class GetdataEvent extends PatientBlocEvent {
  final String patientID;
  final String? type;
  final Patient patient;

  GetdataEvent(
    this.patientID,
    this.patient,
    this.type,
  );
}

class DeletePatientMedicationEvent extends PatientBlocEvent {
  final String medicationID;
  final String patientID;

  DeletePatientMedicationEvent(this.medicationID, this.patientID);
}
class DeleteMobilityProblemEvent extends PatientBlocEvent {
  final String mobilityProblemID;
  final String patientID;

  DeleteMobilityProblemEvent(this.mobilityProblemID, this.patientID);
}

class DeleteXrayEvent extends PatientBlocEvent {
  final String xrayId;
  final String patientId;

  DeleteXrayEvent({required this.xrayId, required this.patientId});
}

class DeleteSurgeryEvent extends PatientBlocEvent {
  final String surgeryId;
  final String patientId;

  DeleteSurgeryEvent({required this.surgeryId, required this.patientId});
}

class DeleteChronicDiseaseEvent extends PatientBlocEvent {
  final String patientId;
  final String chronicDiseaseId;
  final Patient patient;

  DeleteChronicDiseaseEvent(
      this.chronicDiseaseId, this.patientId, this.patient);
}

class DeleteAllergiesEvent extends PatientBlocEvent {
  final String patientId;
  final Patient patient;
  final String allergiesID;

  DeleteAllergiesEvent(this.patientId, this.patient, this.allergiesID);
}

class UpdateDoctorInfoEvent extends PatientBlocEvent {
  final Doctor doctor;
  final Patient patient;

  UpdateDoctorInfoEvent(this.doctor, this.patient);
}

class UpdatePatientMedicalInfoInfoEvent extends PatientBlocEvent {
  final MedicalInformation medicalInformation;
  final Patient patient;

  UpdatePatientMedicalInfoInfoEvent(
      {required this.medicalInformation, required this.patient});
}

class UpdateInsuranceEvent extends PatientBlocEvent {
  final InsuranceModel insurance;
  final Patient patient;
  final String insuranceId;

  UpdateInsuranceEvent(this.insurance, this.patient, this.insuranceId);
}

class GetInsuranceEvent extends PatientBlocEvent {
  final Patient patient;

  GetInsuranceEvent(this.patient);
}

// class DeleteXrayEvent extends PatientBlocEvent {
//   final String xrayId;
//   final String patientId;

//   DeleteXrayEvent({required this.xrayId, required this.patientId});
// }

// class DeleteSurgeryEvent extends PatientBlocEvent {
//   final String surgeryId;
//   final String patientId;

//   DeleteSurgeryEvent({required this.surgeryId, required this.patientId});
// }
