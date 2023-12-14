import 'dart:convert';

class MedicalInformation {
  String? id;
  String? communication;
  String? medicalCondition;
  // String? allergens;
  String? isSmoker;

  MedicalInformation({
    this.id,
    this.communication,
    this.medicalCondition,
    // this.allergens,
    this.isSmoker,
  });

  factory MedicalInformation.fromMap(Map<String, dynamic> map) {
    return MedicalInformation(
      id: map['id'] ?? '',
      communication: map['communication_challenge'] ?? '',
      medicalCondition: map['medical_device'] ??
          '', // Note the field name might be truncated in your screenshot
      // allergens: map['allergens'] ?? '',
      isSmoker: map['is_smooker'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'communication_challenge': communication,
      'medical_device': medicalCondition,
      // 'allergens': allergens,
      'is_smooker': isSmoker,
    };
  }

  factory MedicalInformation.fromJson(String source) =>
      MedicalInformation.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
