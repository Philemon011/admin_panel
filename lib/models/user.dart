class User {
  int? id;
  String? name;
  String? email;
  String? lib;

  User({ this.name, this.email, this.lib});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    lib = json['lib'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['lib'] = this.lib;
    return data;
  }
}
