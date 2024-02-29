// To parse this JSON data, do
//
//     final createStopTimeResModel = createStopTimeResModelFromJson(jsonString);

import 'dart:convert';

CreateStopTimeResModel createStopTimeResModelFromJson(String str) => CreateStopTimeResModel.fromJson(json.decode(str));

String createStopTimeResModelToJson(CreateStopTimeResModel data) => json.encode(data.toJson());

class CreateStopTimeResModel {
  String? id;
  String? vehicle;
  String? routeId;
  String? stopId;
  String? currentTime;
  String? errorMsg;

  CreateStopTimeResModel({
    this.id,
    this.vehicle,
    this.routeId,
    this.stopId,
    this.currentTime,
  });

  factory CreateStopTimeResModel.fromJson(Map<String, dynamic> json) => CreateStopTimeResModel(
        id: json["id"],
        vehicle: json["vehicle"],
        routeId: json["route_id"],
        stopId: json["stop_id"],
        currentTime: json["current_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle": vehicle,
        "route_id": routeId,
        "stop_id": stopId,
        "current_time": currentTime,
      };
}
