class SurgeryModel {
  String? label;
  String? surgeryReport;
  String? date;
  String? placement;
  String? id;
  String? patientId;

  SurgeryModel(
      {this.label,
      this.surgeryReport,
      this.date,
      this.placement,
      this.id,
      this.patientId});

  SurgeryModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    surgeryReport = json['surgery_report'];
    date = json['date'];
    placement = json['placement'];
    id = json['id'];
    patientId = json['patient_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['surgery_report'] = surgeryReport;
    data['date'] = date;
    data['placement'] = placement;
    data['patient_id'] = patientId;
    return data;
  }
}
