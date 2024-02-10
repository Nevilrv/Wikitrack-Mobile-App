// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  int? statusCode;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? role;
  String? token;
  DateTime? expires;
  String? message;

  RegisterResponseModel({
    this.statusCode,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.role,
    this.token,
    this.expires,
    this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        statusCode: json["statusCode"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        token: json["token"],
        expires:
            json["expires"] == null ? null : DateTime.parse(json["expires"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "role": role,
        "token": token,
        "expires": expires?.toIso8601String(),
        "message": message,
      };
}
