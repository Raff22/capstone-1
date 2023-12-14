class ChronicDisease {
  String? disease;
  String? id;

  ChronicDisease({this.disease, this.id});

  ChronicDisease.fromJson(Map<String, dynamic> json) {
    disease = json['disease'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disease'] = disease;
    return data;
  }
}
