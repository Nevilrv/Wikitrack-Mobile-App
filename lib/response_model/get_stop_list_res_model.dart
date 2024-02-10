// To parse this JSON data, do
//
//     final getStopListResModel = getStopListResModelFromJson(jsonString);

import 'dart:convert';

GetStopListResModel getStopListResModelFromJson(String str) => GetStopListResModel.fromJson(json.decode(str));

String getStopListResModelToJson(GetStopListResModel data) => json.encode(data.toJson());

class GetStopListResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GetStopListResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GetStopListResModel.fromJson(Map<String, dynamic> json) => GetStopListResModel(
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
  String stopNo;
  String name;
  StopDisplay? stopDisplay;
  String location;
  bool status;

  Result({
    required this.id,
    required this.stopNo,
    required this.name,
    required this.stopDisplay,
    required this.location,
    required this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
  String id;
  String imei;
  String type;
  bool status;

  StopDisplay({
    required this.id,
    required this.imei,
    required this.type,
    required this.status,
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
