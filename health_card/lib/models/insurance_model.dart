import 'dart:convert';

class InsuranceModel {
  String? companyName;
  String? patientInsuranceId;
  String? coverage;
  String? contacts;
  String? status;
  String? id;

  InsuranceModel(
      {this.companyName,
      this.patientInsuranceId,
      this.coverage,
      this.contacts,
      this.status,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'company_name': companyName,
      'patient_insurance_id': patientInsuranceId,
      'coverage': coverage,
      'contacts': contacts,
      'status': status,
    };
  }

  factory InsuranceModel.fromMap(Map<String, dynamic> map) {
    return InsuranceModel(
      id: map['id'] ?? '',
      companyName: map['company_name'] ?? '',
      patientInsuranceId: map['patient_insurance_id'] ?? '',
      coverage: map['coverage'] ?? '',
      contacts: map['contacts'] ?? '',
      status: map['status'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory InsuranceModel.fromJson(String source) =>
      InsuranceModel.fromJson(json.decode(source));

  // InsuranceModel.fromJson(Map<String, dynamic> json) {
  //   companyName = json['company_name'];
  //   patientInsuranceId = json['patient_insurance_id'];
  //   coverage = json['coverage'];
  //   contacts = json['contacts'];
  //   status = json['status'];
  //   id = json['id'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['company_name'] = companyName;
  //   data['patient_insurance_id'] = patientInsuranceId;
  //   data['coverage'] = coverage;
  //   data['contacts'] = contacts;
  //   data['status'] = status;
  //   return data;
  // }
}
