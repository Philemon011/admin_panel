class Role {
  int? id;
  int? niveau;
  String? lib;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.lib, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    niveau = json['niveau'];
    lib = json['lib'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['niveau'] = this.niveau;
    data['lib'] = this.lib;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
