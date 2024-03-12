// To parse this JSON data, do
//
//     final createTimeTableIdResModel = createTimeTableIdResModelFromJson(jsonString);

import 'dart:convert';

CreateTimeTableIdResModel createTimeTableIdResModelFromJson(String str) =>
    CreateTimeTableIdResModel.fromJson(json.decode(str));

String createTimeTableIdResModelToJson(CreateTimeTableIdResModel data) => json.encode(data.toJson());

class CreateTimeTableIdResModel {
  String? id;
  String? route;
  bool? status;

  CreateTimeTableIdResModel({
    this.id,
    this.route,
    this.status,
  });

  factory CreateTimeTableIdResModel.fromJson(Map<String, dynamic> json) => CreateTimeTableIdResModel(
        id: json["id"],
        route: json["route"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route,
        "status": status,
      };
}
