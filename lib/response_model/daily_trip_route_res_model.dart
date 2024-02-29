// To parse this JSON data, do
//
//     final dailyTripRouteResModel = dailyTripRouteResModelFromJson(jsonString);

import 'dart:convert';

DailyTripRouteResModel dailyTripRouteResModelFromJson(String str) => DailyTripRouteResModel.fromJson(json.decode(str));

String dailyTripRouteResModelToJson(DailyTripRouteResModel data) => json.encode(data.toJson());

class DailyTripRouteResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  DailyTripRouteResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory DailyTripRouteResModel.fromJson(Map<String, dynamic> json) => DailyTripRouteResModel(
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
  List<dynamic> dailyrouteTimeslot;
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
        dailyrouteTimeslot: List<dynamic>.from(json["dailyroute_timeslot"].map((x) => x)),
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dailyroute_timeslot": List<dynamic>.from(dailyrouteTimeslot.map((x) => x)),
        "time": time,
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
