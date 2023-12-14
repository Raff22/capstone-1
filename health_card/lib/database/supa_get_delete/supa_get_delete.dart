// ignore_for_file: unused_local_variable
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health_card/models/EmergencyContact_model.dart';
import 'package:health_card/models/MobilityProblem_model.dart';
import 'package:health_card/models/MedicalInformation_model.dart';
import 'package:health_card/models/XRay_model.dart';
import 'package:health_card/models/allergies_model.dart';
import 'package:health_card/models/chronic_disease_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/insurance_model.dart';
import 'package:health_card/models/medications_model.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/paramedic_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/models/surgery_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaGetAndDelete {
  final supabase = Supabase.instance.client;

  getParamedic(String id) async {
    print("got here in getParamedic");
    print("id $id");
    try {
      final response =
          await supabase.from('paramedic').select().eq('moseefy_id', id);
      print(response);
      if (response.isEmpty) {
        return null;
      } else {
        print("else in getParamedic");
        return Paramedic.fromJson(response[0]);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getPatientByEmail(String email) async {
    print("got here in getPatient");
    try {
      final response =
          await supabase.from('patients').select().eq('email', email);
      print(response);
      if (response.isEmpty) {
        return null;
      } else {
        print("else in getPatient");
        return Patient.fromJson(response[0]);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getPatientById(String id) async {
    try {
      final response = await supabase.from('patients').select().eq('id', id);
      if (response.isEmpty) {
        return null;
      } else {
        return Patient.fromJson(response[0]);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getChronicDiseases(String patientId) async {
    List<ChronicDisease> chronicDiseaseList = [];
    try {
      final response = await supabase
          .from('patients_chronic_diseases')
          .select()
          .eq('patient_id', patientId);
      if (response.isNotEmpty) {
        for (var e in response) {
          final response2 = await supabase
              .from('chronic_diseases')
              .select()
              .eq('id:', e['chronic_disease_id']);
          chronicDiseaseList.add(ChronicDisease.fromJson(response2[0]));
        }
      }
      return chronicDiseaseList;
    } catch (error) {
      print(error.toString());
    }
  }

  getAllergies(String patientId) async {
    List<Allergies> allergiesList = [];
    try {
      final response =
          await supabase.from('allergies').select().eq('patient_id', patientId);

      print(response);
      if (response.isNotEmpty) {
        for (var e in response) {
          allergiesList.add(Allergies.fromJson(e));
          print('getAllergies List');
          print(allergiesList);
        }
      }
      return allergiesList;
    } catch (error) {
      print(error.toString());
    }
  }

  deleteAllergies(String allrgiesId) async {
    try {
      final response =
          await supabase.from('allergies').delete().eq('id', allrgiesId);
    } catch (error) {
      print(error.toString());
    }
  }

  deleteChronicDisease(String patientId, String chronicDiseaseId) async {
    try {
      print(
          'Im comming to delete  deleeeeeted is delete ch $chronicDiseaseId ______________ $patientId');
      final response = await supabase
          .from('patients_chronic_diseases')
          .delete()
          .eq('patient_id', patientId)
          .eq('chronic_disease_id', chronicDiseaseId);
      await supabase
          .from('chronic_diseases')
          .delete()
          .eq('id', chronicDiseaseId);
      print(
          'has been deleeeeeted is delete ch $chronicDiseaseId ______________ $patientId');
    } catch (error) {
      print(error.toString());
    }
  }

  getPersonalInformationById(String id) async {
    try {
      final response =
          await supabase.from('personal_information').select().eq('id', id);
      print(
          "---------------------------supa---------------------------------------------------------");

      if (response.isEmpty) {
        return null;
      } else {
        print('@@@ ${response[0]}');
        return PersonalInfo.fromMap(response[0]);
      }
    } catch (error) {
      print('Error:  ${error.toString()}');
    }
  }

  getDoctorById(String id) async {
    try {
      final response = await supabase.from('doctors').select().eq('id', id);
      print(
          "-------------------------------Doctorrrrr-----------------------------------------------------");
      print(response);
      if (response.isEmpty) {
        return null;
      } else {
        return Doctor.fromMap(response[0]);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getInsurance(String id) async {
    try {
      final response = await supabase.from('insurance').select().eq('id', id);
      print(response);
      if (response.isEmpty) {
        return null;
      } else {
        return InsuranceModel.fromMap(response[0]);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  deleteInsurance(String insuranceID, Patient patient) async {
    try {
      patient.insuranceId = null;
      final response2 = await supabase
          .from('patients')
          .update(patient.toJson())
          .eq('id', patient.id)
          .select();
      print(response2);
      if (response2 != null) {
        await supabase.from('insurance').delete().eq('id', insuranceID);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getMedicalInformation(String id) async {
    try {
      final response =
          await supabase.from('medical_information').select().eq('id', id);
      print(
          "------------------------------------------------------------------------------------");
      print(response[0]);
      if (response.isEmpty) {
        return null;
      } else {
        return MedicalInformation.fromMap(response[0]);
      }
    } catch (error) {
      print('Error : ${error.toString()}');
    }
  }

  deleteMedicalInformation(
      MedicalInformation medicalInformationId, Patient patient) async {
    try {
      patient.medicalInformationId = null;
      final response2 = await supabase
          .from('patients')
          .update(patient.toJson())
          .eq('id', patient.id)
          .select();
      print(response2);
      if (response2 != null) {
        await supabase
            .from('medical_information')
            .delete()
            .eq('id', medicalInformationId);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<Medication>> getMedicationsByPatientId(String patientId) async {
    final response = await supabase
        .from('medications')
        .select()
        .eq('patient_id', patientId)
        .execute();
    final List<dynamic> dataList = response.data
        as List<dynamic>; // Cast the response data to List<dynamic>.
    return dataList
        .map((medicationData) =>
            Medication.fromMap(medicationData as Map<String, dynamic>))
        .toList();
  }

  deleteDoctor(String doctorId, Patient patient) async {
    try {
      patient.doctorId = null;
      final response2 = await supabase
          .from('patients')
          .update(patient.toJson())
          .eq('id', patient.id)
          .select();
      print(response2);
      if (response2 != null) {
        await supabase.from('doctors').delete().eq('id', doctorId);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getXray(String patientId) async {
    print("in get xray");
    List<XRay> xrayList = [];
    try {
      final response =
          await supabase.from('xrays').select().eq('patient_id', patientId);
      print(response);
      if (response.isNotEmpty) {
        for (var e in response) {
          xrayList.add(XRay.fromMap(e));
        }
      }
      return xrayList;
    } catch (error) {
      print(error.toString());
    }
  }

  deletXray(String id) async {
    try {
      final response = await supabase.from('xrays').delete().eq('id', id);
    } catch (error) {
      print(error.toString());
    }
  }

  getMobilityProblems(String patientId) async {
    List<MobilityProblem> mobilityProblemsList = [];
    try {
      final response = await supabase
          .from('mobility_problems')
          .select()
          .eq('patinet_id', patientId);
      if (response.isNotEmpty) {
        for (var e in response) {
          mobilityProblemsList.add(MobilityProblem.fromMap(e));
        }
      }
      return mobilityProblemsList;
    } catch (error) {
      print(error.toString());
    }
  }

  deletMobilityProblem(String problemID) async {
    try {
      final response =
          await supabase.from('mobility_problems').delete().eq('id', problemID);
    } catch (error) {
      print(error.toString());
    }
  }

  getMedications(String? patientId) async {
    List<Medication> medicationList = [];
    try {
      print("1");
      final response = await supabase
          .from('medications')
          .select()
          .eq('patient_id', patientId);
      print("2");

      if (response.isNotEmpty) {
        for (var e in response) {
          medicationList.add(Medication.fromMap(e));
        }
      }
      print("3");

      return medicationList;
    } catch (error) {
      print(error.toString());
    }
  }

  deletMedication(String medicationID) async {
    try {
      final response =
          await supabase.from('medications').delete().eq('id', medicationID);
    } catch (error) {
      print(error.toString());
    }
  }

  // ----------------------- Emergency Add - Get - Delete ---------------------

  getSerguryById(String id) async {
    try {
      final response =
          await supabase.from('surgeries').select().eq('patient_id', id);
      print(
          "------------------------------------------------------------------------------------");
      print(response);
      List<SurgeryModel> temp = [];
      if (response.isNotEmpty) {
        for (var e in response) {
          temp.add(SurgeryModel.fromJson(e));
        }
      }
      return temp;
    } catch (error) {
      print(error.toString());
    }
  }

  deletSergury(String id) async {
    try {
      final response = await supabase.from('surgeries').delete().eq('id', id);
    } catch (error) {
      print(error.toString());
    }
  }

  getEmergencyContact(String id) async {
    List<EmergencyContact> emergencyContact = [];

    try {
      final response = await supabase
          .from('emergency_contacts')
          .select()
          .eq('patient_id', id);
      print(
          "---------------------------getEmergencyContact------------------------------");
      // print(id);
      // print('%%% ${response} %%%');

      if (response.isNotEmpty) {
        for (var e in response) {
          emergencyContact.add(EmergencyContact.fromMap(e));
        }
      }

      return emergencyContact;
    } catch (error) {
      print('Error:  ${error.toString()}');
    }
  }

  deleteEmergencyContact(String emergencyId) async {
    try {
      final response = await supabase
          .from('emergency_contacts')
          .delete()
          .eq('id', emergencyId);
    } catch (error) {
      print(error.toString());
    }
  }
}

// ----------------------------------------------------------------------------

supaInitializer() async {
  await Supabase.initialize(
    url: dotenv.env['URL']!,
    anonKey: dotenv.env['ANONKEY']!,
  );
}
