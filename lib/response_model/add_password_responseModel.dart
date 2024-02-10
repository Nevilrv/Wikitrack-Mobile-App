// To parse this JSON data, do
//
//     final addPasswordResponseModel = addPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

AddPasswordResponseModel addPasswordResponseModelFromJson(String str) =>
    AddPasswordResponseModel.fromJson(json.decode(str));

String addPasswordResponseModelToJson(AddPasswordResponseModel data) =>
    json.encode(data.toJson());

class AddPasswordResponseModel {
  String? detail;

  AddPasswordResponseModel({
    this.detail,
  });

  factory AddPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPasswordResponseModel(
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
