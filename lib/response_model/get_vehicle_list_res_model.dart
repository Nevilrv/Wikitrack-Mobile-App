// To parse this JSON data, do
//
//     final getVehicleListResModel = getVehicleListResModelFromJson(jsonString);

import 'dart:convert';

GetVehiclesListResModel getVehicleListResModelFromJson(String str) =>
    GetVehiclesListResModel.fromJson(json.decode(str));

String getVehicleListResModelToJson(GetVehiclesListResModel data) => json.encode(data.toJson());

class GetVehiclesListResModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  GetVehiclesListResModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetVehiclesListResModel.fromJson(Map<String, dynamic> json) => GetVehiclesListResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  String? id;
  String? chassisNo;
  String? vehicleImg;
  String? regNo;
  BusDisplay? busDisplay;
  GpsDisplay? gpsDevice;
  List<DailyrouteVehicle>? dailyrouteVehicle;
  bool? status;

  Result({
    this.id,
    this.chassisNo,
    this.vehicleImg,
    this.regNo,
    this.busDisplay,
    this.gpsDevice,
    this.dailyrouteVehicle,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        chassisNo: json["chassis_no"],
        vehicleImg: json["vehicle_img"],
        regNo: json["reg_no"],
        busDisplay: json["bus_display"] == null ? json["bus_display"] : BusDisplay.fromJson(json["bus_display"]),
        gpsDevice: json["gps_device"] == null ? json["gps_device"] : GpsDisplay.fromJson(json["gps_device"]),
        dailyrouteVehicle: json["dailyroute_vehicle"] == null
            ? null
            : List<DailyrouteVehicle>.from(json["dailyroute_vehicle"].map((x) => DailyrouteVehicle.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "vehicle_img": vehicleImg,
        "reg_no": regNo,
        "bus_display": busDisplay?.toJson(),
        "gps_device": gpsDevice,
        "dailyroute_vehicle":
            dailyrouteVehicle == null ? null : List<dynamic>.from(dailyrouteVehicle!.map((x) => x.toJson())),
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

class GpsDisplay {
  String? id;
  String? imei;
  bool? status;

  GpsDisplay({
    this.id,
    this.imei,
    this.status,
  });

  factory GpsDisplay.fromJson(Map<String, dynamic> json) => GpsDisplay(
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

class DailyrouteVehicle {
  String id;
  Timeslot timeslot;
  bool status;

  DailyrouteVehicle({
    required this.id,
    required this.timeslot,
    required this.status,
  });

  factory DailyrouteVehicle.fromJson(Map<String, dynamic> json) => DailyrouteVehicle(
        id: json["id"],
        timeslot: Timeslot.fromJson(json["timeslot"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeslot": timeslot.toJson(),
        "status": status,
      };
}

class Timeslot {
  String id;
  String time;
  Dayslot dayslot;
  bool status;

  Timeslot({
    required this.id,
    required this.time,
    required this.dayslot,
    required this.status,
  });

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
        id: json["id"],
        time: json["time"],
        dayslot: Dayslot.fromJson(json["dayslot"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "dayslot": dayslot.toJson(),
        "status": status,
      };
}

class Dayslot {
  String id;
  String day;
  Timetable timetable;
  bool status;

  Dayslot({
    required this.id,
    required this.day,
    required this.timetable,
    required this.status,
  });

  factory Dayslot.fromJson(Map<String, dynamic> json) => Dayslot(
        id: json["id"],
        day: json["day"],
        timetable: Timetable.fromJson(json["timetable"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "timetable": timetable.toJson(),
        "status": status,
      };
}

class Timetable {
  String id;
  Route route;
  bool status;

  Timetable({
    required this.id,
    required this.route,
    required this.status,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        id: json["id"],
        route: Route.fromJson(json["route"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route.toJson(),
        "status": status,
      };
}

class Route {
  String id;
  String routeNo;
  String name;
  String direction;
  bool status;

  Route({
    required this.id,
    required this.routeNo,
    required this.name,
    required this.direction,
    required this.status,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        routeNo: json["route_no"],
        name: json["name"],
        direction: json["direction"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route_no": routeNo,
        "name": name,
        "direction": direction,
        "status": status,
      };
}
