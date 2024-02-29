// To parse this JSON data, do
//
//     final getStopTimeByRouteNoResModel = getStopTimeByRouteNoResModelFromJson(jsonString);

import 'dart:convert';

GetStopTimeByRouteNoResModel getStopTimeByRouteNoResModelFromJson(String str) =>
    GetStopTimeByRouteNoResModel.fromJson(json.decode(str));

String getStopTimeByRouteNoResModelToJson(GetStopTimeByRouteNoResModel data) => json.encode(data.toJson());

class GetStopTimeByRouteNoResModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<StopTimeByRouteNo>? results;

  GetStopTimeByRouteNoResModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetStopTimeByRouteNoResModel.fromJson(Map<String, dynamic> json) => GetStopTimeByRouteNoResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<StopTimeByRouteNo>.from(json["results"]!.map((x) => StopTimeByRouteNo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class StopTimeByRouteNo {
  String? id;
  String? chassisNo;
  String? regNo;
  String? vehicleImg;
  BusDisplay? busDisplay;
  BusDisplay? gpsDevice;
  StopVehicle? stopVehicle;
  bool? status;

  StopTimeByRouteNo({
    this.id,
    this.chassisNo,
    this.regNo,
    this.vehicleImg,
    this.busDisplay,
    this.gpsDevice,
    this.stopVehicle,
    this.status,
  });

  factory StopTimeByRouteNo.fromJson(Map<String, dynamic> json) => StopTimeByRouteNo(
        id: json["id"],
        chassisNo: json["chassis_no"],
        regNo: json["reg_no"],
        vehicleImg: json["vehicle_img"],
        busDisplay: json["bus_display"] == null ? null : BusDisplay.fromJson(json["bus_display"]),
        gpsDevice: json["gps_device"] == null ? null : BusDisplay.fromJson(json["gps_device"]),
        stopVehicle: json["stop_vehicle"] == null ? null : StopVehicle.fromJson(json["stop_vehicle"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "reg_no": regNo,
        "vehicle_img": vehicleImg,
        "bus_display": busDisplay?.toJson(),
        "gps_device": gpsDevice?.toJson(),
        "stop_vehicle": stopVehicle?.toJson(),
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

class StopVehicle {
  String? id;
  RouteId? routeId;
  StopId? stopId;
  String? currentDate;

  StopVehicle({
    this.id,
    this.routeId,
    this.stopId,
    this.currentDate,
  });

  factory StopVehicle.fromJson(Map<String, dynamic> json) => StopVehicle(
        id: json["id"],
        routeId: json["route_id"] == null ? null : RouteId.fromJson(json["route_id"]),
        stopId: json["stop_id"] == null ? null : StopId.fromJson(json["stop_id"]),
        currentDate: json["current_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route_id": routeId?.toJson(),
        "stop_id": stopId?.toJson(),
        "current_date": currentDate,
      };
}

class RouteId {
  String? id;
  String? routeNo;
  String? name;
  String? direction;
  bool? status;

  RouteId({
    this.id,
    this.routeNo,
    this.name,
    this.direction,
    this.status,
  });

  factory RouteId.fromJson(Map<String, dynamic> json) => RouteId(
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
