// To parse this JSON data, do
//
//     final gpsImeiListResModel = gpsImeiListResModelFromJson(jsonString);

import 'dart:convert';

GpsImeiListResModel gpsImeiListResModelFromJson(String str) => GpsImeiListResModel.fromJson(json.decode(str));

String gpsImeiListResModelToJson(GpsImeiListResModel data) => json.encode(data.toJson());

class GpsImeiListResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GpsImeiListResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GpsImeiListResModel.fromJson(Map<String, dynamic> json) => GpsImeiListResModel(
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
  String imei;
  bool status;

  Result({
    required this.id,
    required this.imei,
    required this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
