// To parse this JSON data, do
//
//     final getDailyRouteTripResModel = getDailyRouteTripResModelFromJson(jsonString);

import 'dart:convert';

GetDailyRouteTripResModel getDailyRouteTripResModelFromJson(String str) =>
    GetDailyRouteTripResModel.fromJson(json.decode(str));

String getDailyRouteTripResModelToJson(GetDailyRouteTripResModel data) => json.encode(data.toJson());

class GetDailyRouteTripResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GetDailyRouteTripResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GetDailyRouteTripResModel.fromJson(Map<String, dynamic> json) => GetDailyRouteTripResModel(
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
  Route route;
  bool status;
  List<DaySlot> daySlot;

  Result({
    required this.id,
    required this.route,
    required this.status,
    required this.daySlot,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        route: Route.fromJson(json["route"]),
        status: json["status"],
        daySlot: List<DaySlot>.from(json["day_slot"].map((x) => DaySlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route.toJson(),
        "status": status,
        "day_slot": List<dynamic>.from(daySlot.map((x) => x.toJson())),
      };
}

class DaySlot {
  String id;
  String day;
  List<TimeSlot> timeSlot;
  bool status;

  DaySlot({
    required this.id,
    required this.day,
    required this.timeSlot,
    required this.status,
  });

  factory DaySlot.fromJson(Map<String, dynamic> json) => DaySlot(
        id: json["id"],
        day: json["day"],
        timeSlot: List<TimeSlot>.from(json["time_slot"].map((x) => TimeSlot.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "time_slot": List<dynamic>.from(timeSlot.map((x) => x.toJson())),
        "status": status,
      };
}

class TimeSlot {
  String id;
  List<DailyrouteTimeslot> dailyrouteTimeslot;
  String time;
  bool status;

  TimeSlot({
    required this.id,
    required this.dailyrouteTimeslot,
    required this.time,
    required this.status,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        id: json["id"],
        dailyrouteTimeslot:
            List<DailyrouteTimeslot>.from(json["dailyroute_timeslot"].map((x) => DailyrouteTimeslot.fromJson(x))),
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dailyroute_timeslot": List<dynamic>.from(dailyrouteTimeslot.map((x) => x.toJson())),
        "time": time,
        "status": status,
      };
}

class DailyrouteTimeslot {
  String id;
  Vehicle vehicle;
  bool status;
  List<ActualTime> actualTime;

  DailyrouteTimeslot({
    required this.id,
    required this.vehicle,
    required this.status,
    required this.actualTime,
  });

  factory DailyrouteTimeslot.fromJson(Map<String, dynamic> json) => DailyrouteTimeslot(
        id: json["id"],
        vehicle: Vehicle.fromJson(json["vehicle"]),
        status: json["status"],
        actualTime: List<ActualTime>.from(json["actual_time"].map((x) => ActualTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle": vehicle.toJson(),
        "status": status,
        "actual_time": List<dynamic>.from(actualTime.map((x) => x.toJson())),
      };
}

class ActualTime {
  String id;
  StopSeq stopSeq;
  String time;

  ActualTime({
    required this.id,
    required this.stopSeq,
    required this.time,
  });

  factory ActualTime.fromJson(Map<String, dynamic> json) => ActualTime(
        id: json["id"],
        stopSeq: StopSeq.fromJson(json["stop_seq"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stop_seq": stopSeq.toJson(),
        "time": time,
      };
}

class StopSeq {
  String id;
  String route;
  int priority;
  String travalTime;
  String stopId;
  String direction;
  bool status;

  StopSeq({
    required this.id,
    required this.route,
    required this.priority,
    required this.travalTime,
    required this.stopId,
    required this.direction,
    required this.status,
  });

  factory StopSeq.fromJson(Map<String, dynamic> json) => StopSeq(
        id: json["id"],
        route: json["route"],
        priority: json["priority"],
        travalTime: json["traval_time"],
        stopId: json["stop_id"],
        direction: json["direction"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route,
        "priority": priority,
        "traval_time": travalTime,
        "stop_id": stopId,
        "direction": direction,
        "status": status,
      };
}

class Vehicle {
  String id;
  String chassisNo;
  String regNo;
  String vehicleImg;
  BusDisplay busDisplay;
  BusDisplay gpsDevice;
  bool status;

  Vehicle({
    required this.id,
    required this.chassisNo,
    required this.regNo,
    required this.vehicleImg,
    required this.busDisplay,
    required this.gpsDevice,
    required this.status,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        chassisNo: json["chassis_no"],
        regNo: json["reg_no"],
        vehicleImg: json["vehicle_img"] ?? "",
        busDisplay: BusDisplay.fromJson(json["bus_display"]),
        gpsDevice: BusDisplay.fromJson(json["gps_device"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "reg_no": regNo,
        "vehicle_img": vehicleImg ?? "",
        "bus_display": busDisplay.toJson(),
        "gps_device": gpsDevice.toJson(),
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
