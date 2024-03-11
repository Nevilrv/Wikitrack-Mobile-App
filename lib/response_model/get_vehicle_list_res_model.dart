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
  String? id;
  DateTime? date;
  Timeslot? timeslot;
  List<ActualTime>? actualTime;
  bool? status;

  DailyrouteVehicle({
    this.id,
    this.date,
    this.timeslot,
    this.actualTime,
    this.status,
  });

  factory DailyrouteVehicle.fromJson(Map<String, dynamic> json) => DailyrouteVehicle(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeslot: json["timeslot"] == null ? null : Timeslot.fromJson(json["timeslot"]),
        actualTime: json["actual_time"] == null
            ? []
            : List<ActualTime>.from(json["actual_time"]!.map((x) => ActualTime.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "timeslot": timeslot?.toJson(),
        "actual_time": actualTime == null ? [] : List<dynamic>.from(actualTime!.map((x) => x.toJson())),
        "status": status,
      };
}

class ActualTime {
  String? id;
  StopSeq? stopSeq;
  String? time;

  ActualTime({
    this.id,
    this.stopSeq,
    this.time,
  });

  factory ActualTime.fromJson(Map<String, dynamic> json) => ActualTime(
        id: json["id"],
        stopSeq: json["stop_seq"] == null ? null : StopSeq.fromJson(json["stop_seq"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stop_seq": stopSeq?.toJson(),
        "time": time,
      };
}

class StopSeq {
  String? id;
  String? route;
  int? priority;
  String? travalTime;
  StopId? stopId;
  String? direction;
  bool? status;

  StopSeq({
    this.id,
    this.route,
    this.priority,
    this.travalTime,
    this.stopId,
    this.direction,
    this.status,
  });

  factory StopSeq.fromJson(Map<String, dynamic> json) => StopSeq(
        id: json["id"],
        route: json["route"],
        priority: json["priority"],
        travalTime: json["traval_time"],
        stopId: json["stop_id"] == null ? null : StopId.fromJson(json["stop_id"]),
        direction: json["direction"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route,
        "priority": priority,
        "traval_time": travalTime,
        "stop_id": stopId?.toJson(),
        "direction": direction,
        "status": status,
      };
}

class StopId {
  String? id;
  String? stopNo;
  String? name;
  StopDisplay? stopDisplay;
  String? location;
  bool? status;

  StopId({
    this.id,
    this.stopNo,
    this.name,
    this.stopDisplay,
    this.location,
    this.status,
  });

  factory StopId.fromJson(Map<String, dynamic> json) => StopId(
        id: json["id"],
        stopNo: json["stop_no"],
        name: json["name"],
        stopDisplay: json["stop_display"] == null ? null : StopDisplay.fromJson(json["stop_display"]),
        location: json["location"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stop_no": stopNo,
        "name": name,
        "stop_display": stopDisplay?.toJson(),
        "location": location,
        "status": status,
      };
}

class StopDisplay {
  String? id;
  String? imei;
  String? type;
  bool? status;

  StopDisplay({
    this.id,
    this.imei,
    this.type,
    this.status,
  });

  factory StopDisplay.fromJson(Map<String, dynamic> json) => StopDisplay(
        id: json["id"],
        imei: json["imei"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imei": imei,
        "type": type,
        "status": status,
      };
}

class Timeslot {
  String? id;
  String? time;
  Dayslot? dayslot;
  bool? status;

  Timeslot({
    this.id,
    this.time,
    this.dayslot,
    this.status,
  });

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
        id: json["id"],
        time: json["time"],
        dayslot: json["dayslot"] == null ? null : Dayslot.fromJson(json["dayslot"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "dayslot": dayslot?.toJson(),
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
