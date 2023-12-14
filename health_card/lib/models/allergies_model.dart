class Allergies {
  String? allergiesName;
  String? id;

  Allergies({this.allergiesName, this.id});

  Allergies.fromJson(Map<String, dynamic> json) {
    allergiesName = json['allergies_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allergies_name'] = allergiesName;
    return data;
  }
}
