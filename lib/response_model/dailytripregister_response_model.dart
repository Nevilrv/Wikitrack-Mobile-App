// To parse this JSON data, do
//
//     final dailyTripRegisterResponseModel = dailyTripRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

DailyTripRegisterResponseModel dailyTripRegisterResponseModelFromJson(
        String str) =>
    DailyTripRegisterResponseModel.fromJson(json.decode(str));

String dailyTripRegisterResponseModelToJson(
        DailyTripRegisterResponseModel data) =>
    json.encode(data.toJson());

class DailyTripRegisterResponseModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<CreateRegisterResult>? results;

  DailyTripRegisterResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DailyTripRegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      DailyTripRegisterResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<CreateRegisterResult>.from(
                json["results"]!.map((x) => CreateRegisterResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class CreateRegisterResult {
  String? id;
  String? chassisNo;
  String? regNo;
  BusDisplay? busDisplay;
  BusDisplay? gpsDevice;
  bool? status;

  CreateRegisterResult({
    this.id,
    this.chassisNo,
    this.regNo,
    this.busDisplay,
    this.gpsDevice,
    this.status,
  });

  factory CreateRegisterResult.fromJson(Map<String, dynamic> json) =>
      CreateRegisterResult(
        id: json["id"],
        chassisNo: json["chassis_no"],
        regNo: json["reg_no"],
        busDisplay: json["bus_display"] == null
            ? null
            : BusDisplay.fromJson(json["bus_display"]),
        gpsDevice: json["gps_device"] == null
            ? null
            : BusDisplay.fromJson(json["gps_device"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "reg_no": regNo,
        "bus_display": busDisplay?.toJson(),
        "gps_device": gpsDevice?.toJson(),
        "status": status,
      };
}

class BusDisplay {
  String? id;
  String? imei;
  bool? status;

  BusDisplay({
    this.id,
    this.imei,
    this.status,
  });

  factory BusDisplay.fromJson(Map<String, dynamic> json) => BusDisplay(
        id: json["id"],
        imei: json["imei"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imei": imei,
        "status": status,
      };
}
