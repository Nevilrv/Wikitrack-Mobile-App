// To parse this JSON data, do
//
//     final busDisplayResModel = busDisplayResModelFromJson(jsonString);

import 'dart:convert';

BusDisplayResModel busDisplayResModelFromJson(String str) => BusDisplayResModel.fromJson(json.decode(str));

String busDisplayResModelToJson(BusDisplayResModel data) => json.encode(data.toJson());

class BusDisplayResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  BusDisplayResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BusDisplayResModel.fromJson(Map<String, dynamic> json) => BusDisplayResModel(
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
