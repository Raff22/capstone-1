import 'dart:convert';

class PersonalInfo {
  String? id;
  String? image;
  String? nationalId;
  double? weight;
  double? height;
  String? birthday;
  String? bloodType;

  PersonalInfo({
    this.id,
    this.image,
    this.nationalId,
    this.weight,
    this.height,
    this.birthday,
    this.bloodType,
  });

  factory PersonalInfo.fromMap(Map<String, dynamic> map) {
    return PersonalInfo(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      nationalId: map['national_id'] ?? 0,
      weight: map['weight']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      birthday: map['birthday'],
      bloodType: map['blood_type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'national_id': nationalId,
      'weight': weight,
      'height': height,
      'birthday': birthday,
      'blood_type': bloodType,
    };
  }

  factory PersonalInfo.fromJson(String source) =>
      PersonalInfo.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
