class User {
  int id;

  String name;
  String code;
  String email;
  String phone;
  String countryCode;
  String photo;
  String role;
  String address;
  String actype;
  String acnumber;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.countryCode,
      this.photo,
      this.role,
      this.address,
      this.actype,
      this.acnumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'] ?? "";
    phone = json['phone'];
    address = json['address'];
    actype = json['actype'];
    acnumber = json['acnumber'];
    countryCode = json['country_code'];
    photo = json['photo'] ?? "";
    role = json['role_name'] ?? "client";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'actype': actype,
      'acnumber': acnumber,
      'country_code': countryCode,
      'photo': photo,
      'role_name': role,
    };
  }
}
