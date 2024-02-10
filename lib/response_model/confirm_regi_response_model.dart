// To parse this JSON data, do
//
//     final confirmRegiResponseModel = confirmRegiResponseModelFromJson(jsonString);

import 'dart:convert';

ConfirmRegiResponseModel confirmRegiResponseModelFromJson(String str) =>
    ConfirmRegiResponseModel.fromJson(json.decode(str));

String confirmRegiResponseModelToJson(ConfirmRegiResponseModel data) => json.encode(data.toJson());

class ConfirmRegiResponseModel {
  String? status;
  String? message;
  bool? success;

  ConfirmRegiResponseModel({
    this.status,
    this.message,
    this.success,
  });

  factory ConfirmRegiResponseModel.fromJson(Map<String, dynamic> json) => ConfirmRegiResponseModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
      };
}
