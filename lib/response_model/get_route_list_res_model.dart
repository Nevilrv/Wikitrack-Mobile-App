// // To parse this JSON data, do
// //
// //     final getRouteListResModel = getRouteListResModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetRouteListResModel getRouteListResModelFromJson(String str) => GetRouteListResModel.fromJson(json.decode(str));
//
// String getRouteListResModelToJson(GetRouteListResModel data) => json.encode(data.toJson());
//
// class GetRouteListResModel {
//   int count;
//   dynamic next;
//   dynamic previous;
//   List<Result> results;
//
//   GetRouteListResModel({
//     required this.count,
//     required this.next,
//     required this.previous,
//     required this.results,
//   });
//
//   factory GetRouteListResModel.fromJson(Map<String, dynamic> json) => GetRouteListResModel(
//         count: json["count"],
//         next: json["next"],
//         previous: json["previous"],
//         results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "count": count,
//         "next": next,
//         "previous": previous,
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//       };
// }
//
// class Result {
//   String id;
//   String routeNo;
//   String name;
//   String direction;
//   bool status;
//   List<StopSequence> stopSequence;
//
//   Result({
//     required this.id,
//     required this.routeNo,
//     required this.name,
//     required this.direction,
//     required this.status,
//     required this.stopSequence,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         routeNo: json["route_no"],
//         name: json["name"],
//         direction: json["direction"],
//         status: json["status"],
//         stopSequence: List<StopSequence>.from(json["StopSequence"].map((x) => StopSequence.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "route_no": routeNo,
//         "name": name,
//         "direction": direction,
//         "status": status,
//         "StopSequence": List<dynamic>.from(stopSequence.map((x) => x.toJson())),
//       };
// }
//
// class StopSequence {
//   String id;
//   int priority;
//   String travalTime;
//   bool status;
//   StopId stopId;
//
//   StopSequence({
//     required this.id,
//     required this.priority,
//     required this.travalTime,
//     required this.status,
//     required this.stopId,
//   });
//
//   factory StopSequence.fromJson(Map<String, dynamic> json) => StopSequence(
//         id: json["id"],
//         priority: json["priority"],
//         travalTime: json["traval_time"],
//         status: json["status"],
//         stopId: StopId.fromJson(json["stop_id"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "priority": priority,
//         "traval_time": travalTime,
//         "status": status,
//         "stop_id": stopId.toJson(),
//       };
// }
//
// class StopId {
//   String id;
//   String stopNo;
//   String name;
//   dynamic stopDisplay;
//   String location;
//   bool status;
//
//   StopId({
//     required this.id,
//     required this.stopNo,
//     required this.name,
//     required this.stopDisplay,
//     required this.location,
//     required this.status,
//   });
//
//   factory StopId.fromJson(Map<String, dynamic> json) => StopId(
//         id: json["id"],
//         stopNo: json["stop_no"],
//         name: json["name"],
//         stopDisplay: json["stop_display"],
//         location: json["location"],
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "stop_no": stopNo,
//         "name": name,
//         "stop_display": stopDisplay,
//         "location": location,
//         "status": status,
//       };
// }

// To parse this JSON data, do
//
//     final getRouteListResModel = getRouteListResModelFromJson(jsonString);

import 'dart:convert';

GetRouteListResModel getRouteListResModelFromJson(String str) => GetRouteListResModel.fromJson(json.decode(str));

String getRouteListResModelToJson(GetRouteListResModel data) => json.encode(data.toJson());

class GetRouteListResModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<RouteResult>? results;

  GetRouteListResModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetRouteListResModel.fromJson(Map<String, dynamic> json) => GetRouteListResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            json["results"] == null ? [] : List<RouteResult>.from(json["results"]!.map((x) => RouteResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class RouteResult {
  String? id;
  String? routeNo;
  String? name;
  String? direction;
  bool? status;
  List<StopSequence>? stopSequence;

  RouteResult({
    this.id,
    this.routeNo,
    this.name,
    this.direction,
    this.status,
    this.stopSequence,
  });

  factory RouteResult.fromJson(Map<String, dynamic> json) => RouteResult(
        id: json["id"],
        routeNo: json["route_no"],
        name: json["name"],
        direction: json["direction"],
        status: json["status"] == null ? false : true,
        stopSequence: json["StopSequence"] == null
            ? []
            : List<StopSequence>.from(json["StopSequence"]!.map((x) => StopSequence.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route_no": routeNo,
        "name": name,
        "direction": direction,
        "status": status,
        "StopSequence": stopSequence == null ? [] : List<dynamic>.from(stopSequence!.map((x) => x.toJson())),
      };
}

class StopSequence {
  String? id;
  int? priority;
  String? travalTime;
  bool? status;
  StopId? stopId;

  StopSequence({
    this.id,
    this.priority,
    this.travalTime,
    this.status,
    this.stopId,
  });

  factory StopSequence.fromJson(Map<String, dynamic> json) => StopSequence(
        id: json["id"],
        priority: json["priority"],
        travalTime: json["traval_time"],
        status: json["status"],
        stopId: json["stop_id"] == null ? null : StopId.fromJson(json["stop_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priority": priority,
        "traval_time": travalTime,
        "status": status,
        "stop_id": stopId?.toJson(),
      };
}

class StopId {
  String? id;
  String? stopNo;
  String? name;
  dynamic stopDisplay;
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
        stopDisplay: json["stop_display"],
        location: json["location"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stop_no": stopNo,
        "name": name,
        "stop_display": stopDisplay,
        "location": location,
        "status": status,
      };
}
