// To parse this JSON data, do
//
//     final getVehicleListResModel = getVehicleListResModelFromJson(jsonString);

import 'dart:convert';

GetVehicleListResModel getVehicleListResModelFromJson(String str) => GetVehicleListResModel.fromJson(json.decode(str));

String getVehicleListResModelToJson(GetVehicleListResModel data) => json.encode(data.toJson());

class GetVehicleListResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GetVehicleListResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GetVehicleListResModel.fromJson(Map<String, dynamic> json) => GetVehicleListResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String id;
  String chassisNo;
  String regNo;
  BusDisplay busDisplay;
  dynamic gpsDevice;
  bool status;

  Result({
    required this.id,
    required this.chassisNo,
    required this.regNo,
    required this.busDisplay,
    required this.gpsDevice,
    required this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        chassisNo: json["chassis_no"],
        regNo: json["reg_no"],
        busDisplay: BusDisplay.fromJson(json["bus_display"]),
        gpsDevice: json["gps_device"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "reg_no": regNo,
        "bus_display": busDisplay.toJson(),
        "gps_device": gpsDevice,
        "status": status,
      };
}

class BusDisplay {
  String id;
  String imei;
  bool status;

  BusDisplay({
    required this.id,
    required this.imei,
    required this.status,
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
