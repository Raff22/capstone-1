import 'dart:io';

import 'package:health_card/database/supa_add_update/supa_add_update.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/models/PersonalInfo_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaStorage {
  final supabase = Supabase.instance.client.storage;
  uploadPatientImage(File file, Patient patient) async {
    final fileBytes = await file.readAsBytes();
    final path =
        "patients_images/${patient.id!}${DateTime.now()}profileimage.png";
    try {
      await supabase.from('Health_card_storage').uploadBinary(path, fileBytes);
      final response = supabase.from('Health_card_storage').getPublicUrl(path);
      final url = response;
      print(url);
      if (patient.personalInformationId != null) {
        PersonalInfo temp = await SupaGetAndDelete()
            .getPersonalInformationById(patient.personalInformationId!);
        temp.image = url;
        await SupaAddAndUpdate()
            .updatePatientPersonalInformation(personalInfo: temp);
        return url;
      } else {
        await SupaAddAndUpdate().addPatientPersonalInformation(
            personalInfo: PersonalInfo(image: url), patient: patient);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  updatePatientImage(File file, Patient patient, String path) async {
    try {
      await deletePatientImage(file, patient, path);
      return await uploadPatientImage(file, patient);
    } catch (error) {
      print(error.toString());
    }
    // List pathList = await supabase
    //     .from('Health_card_storage')
    //     .list(path: 'patients_images/');
    // for (FileObject foo in pathList) {
    //   if (foo.name.startsWith(patient.id!)) {
    //     await supabase.from('Health_card_storage').remove([foo.name]);
    //   }
    // }
  }

  deletePatientImage(File file, Patient patient, String path) async {
    print("in delete");
    List pathList = path.split('/');
    path = 'patients_images/';
    path += pathList[pathList.length - 1];
    print(path);
    try {
      await supabase.from('Health_card_storage').remove([path]);
      PersonalInfo temp = await SupaGetAndDelete()
          .getPersonalInformationById(patient.personalInformationId!);
      temp.image = null;
      await SupaAddAndUpdate()
          .updatePatientPersonalInformation(personalInfo: temp);
    } catch (error) {
      print(error.toString());
    }
  }

  uploadXrayReport(File file, Patient patient) async {
    final path = "xray_reports/${patient.id!}${DateTime.now()}xray_report.pdf";
    try {
      await supabase.from('Health_card_storage').upload(path, file);
      final response = supabase.from('Health_card_storage').getPublicUrl(path);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  uploadSurgery(File file, Patient patient) async {
    final path =
        "surgery_reports/${patient.id!}${DateTime.now()}surgery_report.pdf";
    try {
      await supabase.from('Health_card_storage').upload(path, file);
      final response = supabase.from('Health_card_storage').getPublicUrl(path);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }
}
