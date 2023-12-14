import 'dart:convert';

class MobilityProblem {
  String? id;
  String?
      problemType; // Assuming this is a string that represents a custom type in your database
  String? problemName;
  String? problemPlace;
  String? patientId;

  MobilityProblem({
    this.id,
    this.problemType,
    this.problemName,
    this.problemPlace,
    this.patientId,
  });

  factory MobilityProblem.fromMap(Map<String, dynamic> map) {
    return MobilityProblem(
      id: map['id'] ?? '',
      problemType: map['problem_type'] ?? '',
      problemName: map['problem_name'] ?? '',
      problemPlace: map['problem_placement'] ?? '',
      patientId: map['patinet_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problem_type': problemType,
      'problem_name': problemName,
      'problem_placement': problemPlace,
      'patinet_id': patientId,
    };
  }

  factory MobilityProblem.fromJson(String source) =>
      MobilityProblem.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
