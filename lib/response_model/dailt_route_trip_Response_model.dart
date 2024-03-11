// To parse this JSON data, do
//
//     final dailyRouteTripResponseModel = dailyRouteTripResponseModelFromJson(jsonString);

import 'dart:convert';

DailyRouteTripResponseModel dailyRouteTripResponseModelFromJson(String str) =>
    DailyRouteTripResponseModel.fromJson(json.decode(str));

String dailyRouteTripResponseModelToJson(DailyRouteTripResponseModel data) => json.encode(data.toJson());

class DailyRouteTripResponseModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<DailyTripManagementResult>? results;

  DailyRouteTripResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DailyRouteTripResponseModel.fromJson(Map<String, dynamic> json) => DailyRouteTripResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<DailyTripManagementResult>.from(json["results"]!.map((x) => DailyTripManagementResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class DailyTripManagementResult {
  String? id;
  Route? route;
  bool? status;
  List<DaySlot>? daySlot;

  DailyTripManagementResult({
    this.id,
    this.route,
    this.status,
    this.daySlot,
  });

  factory DailyTripManagementResult.fromJson(Map<String, dynamic> json) => DailyTripManagementResult(
        id: json["id"],
        route: json["route"] == null ? null : Route.fromJson(json["route"]),
        status: json["status"],
        daySlot: json["day_slot"] == null ? [] : List<DaySlot>.from(json["day_slot"]!.map((x) => DaySlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route?.toJson(),
        "status": status,
        "day_slot": daySlot == null ? [] : List<dynamic>.from(daySlot!.map((x) => x.toJson())),
      };
}

class DaySlot {
  String? id;
  String? day;
  List<TimeSlot>? timeSlot;
  bool? status;

  DaySlot({
    this.id,
    this.day,
    this.timeSlot,
    this.status,
  });

  factory DaySlot.fromJson(Map<String, dynamic> json) => DaySlot(
        id: json["id"],
        day: json["day"],
        timeSlot:
            json["time_slot"] == null ? [] : List<TimeSlot>.from(json["time_slot"]!.map((x) => TimeSlot.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "time_slot": timeSlot == null ? [] : List<dynamic>.from(timeSlot!.map((x) => x.toJson())),
        "status": status,
      };
}

class TimeSlot {
  String? id;
  List<DailyrouteTimeslot>? dailyrouteTimeslot;
  String? time;
  bool? status;

  TimeSlot({
    this.id,
    this.dailyrouteTimeslot,
    this.time,
    this.status,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        id: json["id"],
        dailyrouteTimeslot: json["dailyroute_timeslot"] == null
            ? []
            : List<DailyrouteTimeslot>.from(json["dailyroute_timeslot"]!.map((x) => DailyrouteTimeslot.fromJson(x))),
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dailyroute_timeslot":
            dailyrouteTimeslot == null ? [] : List<dynamic>.from(dailyrouteTimeslot!.map((x) => x.toJson())),
        "time": time,
        "status": status,
      };
}

class DailyrouteTimeslot {
  String? id;
  DateTime? date;
  Vehicle? vehicle;
  bool? status;
  List<ActualTime>? actualTime;

  DailyrouteTimeslot({
    this.id,
    this.date,
    this.vehicle,
    this.status,
    this.actualTime,
  });

  factory DailyrouteTimeslot.fromJson(Map<String, dynamic> json) => DailyrouteTimeslot(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        status: json["status"],
        actualTime: json["actual_time"] == null
            ? []
            : List<ActualTime>.from(json["actual_time"]!.map((x) => ActualTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "vehicle": vehicle?.toJson(),
        "status": status,
        "actual_time": actualTime == null ? [] : List<dynamic>.from(actualTime!.map((x) => x.toJson())),
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

class Vehicle {
  String? id;
  String? chassisNo;
  String? regNo;
  dynamic vehicleImg;
  BusDisplay? busDisplay;
  BusDisplay? gpsDevice;
  bool? status;

  Vehicle({
    this.id,
    this.chassisNo,
    this.regNo,
    this.vehicleImg,
    this.busDisplay,
    this.gpsDevice,
    this.status,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        chassisNo: json["chassis_no"],
        regNo: json["reg_no"],
        vehicleImg: json["vehicle_img"],
        busDisplay: json["bus_display"] == null ? null : BusDisplay.fromJson(json["bus_display"]),
        gpsDevice: json["gps_device"] == null ? null : BusDisplay.fromJson(json["gps_device"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "reg_no": regNo,
        "vehicle_img": vehicleImg,
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

class Route {
  String? id;
  String? routeNo;
  String? name;
  String? direction;
  bool? status;

  Route({
    this.id,
    this.routeNo,
    this.name,
    this.direction,
    this.status,
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
