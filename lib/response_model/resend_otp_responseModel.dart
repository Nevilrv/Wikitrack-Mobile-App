// To parse this JSON data, do
//
//     final resendOtpResponseModel = resendOtpResponseModelFromJson(jsonString);

import 'dart:convert';

ResendOtpResponseModel resendOtpResponseModelFromJson(String str) =>
    ResendOtpResponseModel.fromJson(json.decode(str));

String resendOtpResponseModelToJson(ResendOtpResponseModel data) =>
    json.encode(data.toJson());

class ResendOtpResponseModel {
  String? status;
  bool? success;

  ResendOtpResponseModel({
    this.status,
    this.success,
  });

  factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      ResendOtpResponseModel(
        status: json["status"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
      };
}
