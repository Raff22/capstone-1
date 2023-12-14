import 'dart:convert';

class EmergencyContact {
  String? id;
  String? name;
  String? phoneNumber;
  String? relationshipType;

  EmergencyContact({
    this.id,
    this.name,
    this.phoneNumber,
    this.relationshipType,
  });

  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      relationshipType: map['relationship_type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'relationship_type': relationshipType,
    };
  }

  factory EmergencyContact.fromJson(String source) =>
      EmergencyContact.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
