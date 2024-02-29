// To parse this JSON data, do
//
//     final getTimeTableListResModel = getTimeTableListResModelFromJson(jsonString);

import 'dart:convert';

GetTimeTableListResModel getTimeTableListResModelFromJson(String str) =>
    GetTimeTableListResModel.fromJson(json.decode(str));

String getTimeTableListResModelToJson(GetTimeTableListResModel data) =>
    json.encode(data.toJson());

class GetTimeTableListResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GetTimeTableListResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GetTimeTableListResModel.fromJson(Map<String, dynamic> json) =>
      GetTimeTableListResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
  List<TimeSlot> timeSlot;

  Result({
    required this.id,
    required this.route,
    required this.status,
    required this.timeSlot,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        route: Route.fromJson(json["route"]),
        status: json["status"],
        timeSlot: List<TimeSlot>.from(
            json["time_slot"].map((x) => TimeSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route.toJson(),
        "status": status,
        "time_slot": List<dynamic>.from(timeSlot.map((x) => x.toJson())),
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

class TimeSlot {
  String id;
  String day;
  String time;
  bool status;

  TimeSlot({
    required this.id,
    required this.day,
    required this.time,
    required this.status,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
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
