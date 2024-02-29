// To parse this JSON data, do
//
//     final geVehicleRouteTripResModel = geVehicleRouteTripResModelFromJson(jsonString);

import 'dart:convert';

GeVehicleRouteTripResModel geVehicleRouteTripResModelFromJson(String str) =>
    GeVehicleRouteTripResModel.fromJson(json.decode(str));

String geVehicleRouteTripResModelToJson(GeVehicleRouteTripResModel data) => json.encode(data.toJson());

class GeVehicleRouteTripResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GeVehicleRouteTripResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GeVehicleRouteTripResModel.fromJson(Map<String, dynamic> json) => GeVehicleRouteTripResModel(
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
  dynamic vehicleImg;
  BusDisplay busDisplay;
  BusDisplay gpsDevice;
  List<DailyrouteVehicle> dailyrouteVehicle;
  bool status;

  Result({
    required this.id,
    required this.chassisNo,
    required this.regNo,
    required this.vehicleImg,
    required this.busDisplay,
    required this.gpsDevice,
    required this.dailyrouteVehicle,
    required this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        chassisNo: json["chassis_no"],
        regNo: json["reg_no"],
        vehicleImg: json["vehicle_img"],
        busDisplay: BusDisplay.fromJson(json["bus_display"]),
        gpsDevice: BusDisplay.fromJson(json["gps_device"]),
        dailyrouteVehicle:
            List<DailyrouteVehicle>.from(json["dailyroute_vehicle"].map((x) => DailyrouteVehicle.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "reg_no": regNo,
        "vehicle_img": vehicleImg,
        "bus_display": busDisplay.toJson(),
        "gps_device": gpsDevice.toJson(),
        "dailyroute_vehicle": List<dynamic>.from(dailyrouteVehicle.map((x) => x.toJson())),
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
