import 'dart:convert';

class Medication {
  String? id;
  String? medicationName;
  String? dose;
  String? medicationTime; // Assuming this is a string representation of time.
  String? picture;
  String? patientId;

  Medication({
    this.id,
    this.medicationName,
    this.dose,
    this.medicationTime,
    this.picture,
    this.patientId,
  });

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'] ?? '',
      medicationName: map['medication_name'] ?? '',
      dose: map['dose'] ?? '',
      medicationTime: map['medication_time'] ?? '',
      picture: map['picture'] ?? '',
      patientId: map['patient_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medication_name': medicationName,
      'dose': dose,
      'medication_time': medicationTime,
      'picture': picture,
      'patient_id': patientId,
    };
  }

  factory Medication.fromJson(String source) =>
      Medication.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
