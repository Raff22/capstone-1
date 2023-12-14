class Patient {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? personalInformationId;
  String? medicalInformationId;
  String? doctorId;
  String? insuranceId;

  Patient(
      {this.id,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.personalInformationId,
      this.medicalInformationId,
      this.doctorId,
      this.insuranceId});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    personalInformationId = json['personal_information_id'];
    medicalInformationId = json['medical_information_id'];
    doctorId = json['doctor_id'];
    insuranceId = json['insurance_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['personal_information_id'] = personalInformationId;
    data['medical_information_id'] = medicalInformationId;
    data['doctor_id'] = doctorId;
    data['insurance_id'] = insuranceId;
    return data;
  }
}
