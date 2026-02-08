class UserModel {
  String id;
  String name;
  String email;
  String nid;
  bool isVerified;


  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    required this.nid,
    this.isVerified = false
  });
  UserModel.fromJson(Map<String, dynamic> json):this(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    nid: json["nid"],

    isVerified: json["isVerified"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "nid": nid,
    "isVerified": isVerified,
  };
}

