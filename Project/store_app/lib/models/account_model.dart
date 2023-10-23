// To parse this JSON Account, do
//
//     final Account = AccountFromJson(jsonString);

import 'dart:convert';

List<Account> dataFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String dataToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  String id;
  String name;
  String username;
  String gender;
  String email;
  int noHp;
  String password;

  Account({
    required this.id,
    required this.name,
    required this.username,
    required this.gender,
    required this.email,
    required this.noHp,
    required this.password,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        username: json["username"] ?? "",
        gender: json["gender"] ?? "",
        email: json["email"] ?? "",
        noHp: json["noHp"] ?? 0,
        password: json["password"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "gender": gender,
        "email": email,
        "noHp": noHp,
        "password": password,
      };
}
