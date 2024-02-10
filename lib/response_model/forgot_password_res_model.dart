// To parse this JSON data, do
//
//     final forgotPasswordResModel = forgotPasswordResModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResModel forgotPasswordResModelFromJson(String str) =>
    ForgotPasswordResModel.fromJson(json.decode(str));

String forgotPasswordResModelToJson(ForgotPasswordResModel data) =>
    json.encode(data.toJson());

class ForgotPasswordResModel {
  String detail;
  // int statusCode;

  ForgotPasswordResModel({
    required this.detail,
    // required this.statusCode,
  });

  factory ForgotPasswordResModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResModel(
        detail: json["detail"],
        // statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
        // "statusCode": statusCode,
      };
}
// To parse this JSON data, do
//
//     final forgetPasswordResponseModel = forgetPasswordResponseModelFromJson(jsonString);
