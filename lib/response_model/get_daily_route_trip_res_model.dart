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
  Timeslot timeslot;
  Vehicle vehicle;
  bool status;
  List<ActualTime> actualTime;

  Result({
    required this.id,
    required this.timeslot,
    required this.vehicle,
    required this.status,
    required this.actualTime,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        timeslot: Timeslot.fromJson(json["timeslot"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
        status: json["status"],
        actualTime: List<ActualTime>.from(json["actual_time"].map((x) => ActualTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeslot": timeslot.toJson(),
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
  int priority;
  String travalTime;
  bool status;
  String stopId;

  StopSeq({
    required this.id,
    required this.priority,
    required this.travalTime,
    required this.status,
    required this.stopId,
  });

  factory StopSeq.fromJson(Map<String, dynamic> json) => StopSeq(
        id: json["id"],
        priority: json["priority"],
        travalTime: json["traval_time"],
        status: json["status"],
        stopId: json["stop_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priority": priority,
        "traval_time": travalTime,
        "status": status,
        "stop_id": stopId,
      };
}

class Timeslot {
  String id;
  String day;
  String time;
  bool status;

  Timeslot({
    required this.id,
    required this.day,
    required this.time,
    required this.status,
  });

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
        id: json["id"],
        day: json["day"],
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "time": time,
        "status": status,
      };
}

class Vehicle {
  String id;
  String chassisNo;
  String regNo;
  String busDisplay;
  dynamic gpsDevice;
  bool status;

  Vehicle({
    required this.id,
    required this.chassisNo,
    required this.regNo,
    required this.busDisplay,
    required this.gpsDevice,
    required this.status,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        chassisNo: json["chassis_no"],
        regNo: json["reg_no"],
        busDisplay: json["bus_display"],
        gpsDevice: json["gps_device"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chassis_no": chassisNo,
        "reg_no": regNo,
        "bus_display": busDisplay,
        "gps_device": gpsDevice,
        "status": status,
      };
}
