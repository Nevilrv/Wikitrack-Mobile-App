// To parse this JSON data, do
//
//     final getTimeTableResModel = getTimeTableResModelFromJson(jsonString);

import 'dart:convert';

GetBusTimeTableResModel getBusTimeTableResModelFromJson(String str) =>
    GetBusTimeTableResModel.fromJson(json.decode(str));

String getBusTimeTableResModelToJson(GetBusTimeTableResModel data) => json.encode(data.toJson());

class GetBusTimeTableResModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<GetBusTimeTable>? results;

  GetBusTimeTableResModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetBusTimeTableResModel.fromJson(Map<String, dynamic> json) => GetBusTimeTableResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<GetBusTimeTable>.from(json["results"]!.map((x) => GetBusTimeTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class GetBusTimeTable {
  String? id;
  Route? route;
  bool? status;
  List<DaySlot>? daySlot;

  GetBusTimeTable({
    this.id,
    this.route,
    this.status,
    this.daySlot,
  });

  factory GetBusTimeTable.fromJson(Map<String, dynamic> json) => GetBusTimeTable(
        id: json["id"],
        route: json["route"] == null ? null : Route.fromJson(json["route"]),
        status: json["status"],
        daySlot: json["day_slot"] == null
            ? []
            : List<DaySlot>.from(json["day_slot"]!.map((x) => DaySlot.fromJson(x))),
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
  bool isVisible;

  DaySlot({
    this.id,
    this.day,
    this.timeSlot,
    this.status,
    this.isVisible = false,
  });

  factory DaySlot.fromJson(Map<String, dynamic> json) => DaySlot(
        id: json["id"],
        day: json["day"],
        timeSlot: json["time_slot"] == null
            ? []
            : List<TimeSlot>.from(json["time_slot"]!.map((x) => TimeSlot.fromJson(x))),
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
  String? time;
  bool? status;

  TimeSlot({
    this.id,
    this.time,
    this.status,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        id: json["id"],
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
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
