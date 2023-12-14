import 'dart:convert';

class XRay {
  String? id;
  String? label;
  String? picture; // Assuming this is a URL or file path to the X-ray image
  String? xrayReport;
  String? date; // If the date is in a specific format, consider using DateTime
  String? patientId;

  XRay({
    this.id,
    this.label,
    this.picture,
    this.xrayReport,
    this.date,
    this.patientId,
  });

  factory XRay.fromMap(Map<String, dynamic> map) {
    return XRay(
      id: map['id'] ?? '',
      label: map['label'] ?? '',
      picture: map['picture'] ?? '',
      xrayReport: map['xray_report'] ?? '',
      date: map['date'] ?? '',
      patientId: map['patient_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'picture': picture,
      'xray_report': xrayReport,
      'date': date,
      'patient_id': patientId,
    };
  }

  factory XRay.fromJson(String source) => XRay.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
