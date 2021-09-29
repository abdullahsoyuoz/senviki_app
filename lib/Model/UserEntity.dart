import 'dart:convert';

class UserEntity {
  String uid;
  String email;
  String name;
  UserEntity({this.uid, this.email, this.name});

  factory UserEntity.fromJson(String str) =>
      UserEntity.fromMap(json.decode(str));

  factory UserEntity.fromMap(Map<String, dynamic> json) {
    return UserEntity(
      uid: json["uid"] == null ? null : json["uid"],
      name: json["name"] == null ? null : json["name"],
      email: json["email"] == null ? null : json["email"],
    );
  }

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "email": email == null ? null : email,
        "name": name == null ? null : name,
      };
}
