class UserData {
  String? name, email,  cnic, phone;

  UserData({this.name, this.cnic, this.email, this.phone});
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "cnic": cnic,
      "Phone": phone,
    };
  }

  UserData.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        email = map["email"],
        cnic = map["cnic"],
        phone = map["phone"];
}
