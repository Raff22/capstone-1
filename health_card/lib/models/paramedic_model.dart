class Paramedic {
  int? id;
  String? name;
  String? email;
  String? moseefyId;
  String? nationalId;
  String? hospital;

  Paramedic(
      {this.id,
      this.name,
      this.email,
      this.moseefyId,
      this.nationalId,
      this.hospital});

  Paramedic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    moseefyId = json['moseefy_id'];
    nationalId = json['national_id'];
    hospital = json['hospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['moseefy_id'] = moseefyId;
    data['national_id'] = nationalId;
    data['hospital'] = hospital;
    return data;
  }
}
