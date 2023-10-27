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

Login userFromJson(String str) => Login.fromJson(json.decode(str));

String userToJson(Login data) => json.encode(data.toJson());

class Login {
  final String id;
  final String username;
  final String email;
  final String gender;
  final int noHp;
  final String name;

  Login({
    required this.id,
    required this.username,
    required this.email,
    required this.gender,
    required this.noHp,
    required this.name,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
        noHp: json["noHp"] ?? 0,
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "gender": gender,
        "noHp": noHp,
        "name": name,
      };
}
