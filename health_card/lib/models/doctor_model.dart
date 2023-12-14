import 'dart:convert';

class Doctor {
  String? id;
  String? name;
  String? speciality;
  String? address;
  String? phone;
  String? email;

  Doctor({
    this.id,
    this.name,
    this.speciality,
    this.address,
    this.phone,
    this.email,
  });

  // Convert a Doctor instance to a Map. Useful for encoding to JSON.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'speciality': speciality,
      'address': address,
      'phone': phone,
      'email': email,
    };
  }

  // Convert a Map to a Doctor instance. Useful for decoding from JSON.
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      speciality: map['speciality'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  // Encode Doctor instance to JSON. Useful for sending data over a network.
  String toJson() => json.encode(toMap());

  // Decode Doctor instance from JSON. Useful for receiving data over a network.
  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source));
}
