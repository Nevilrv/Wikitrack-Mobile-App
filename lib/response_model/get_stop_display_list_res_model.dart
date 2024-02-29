// To parse this JSON data, do
//
//     final getStopDisplayListResModel = getStopDisplayListResModelFromJson(jsonString);

import 'dart:convert';

GetStopDisplayListResModel getStopDisplayListResModelFromJson(String str) =>
    GetStopDisplayListResModel.fromJson(json.decode(str));

String getStopDisplayListResModelToJson(GetStopDisplayListResModel data) =>
    json.encode(data.toJson());

class GetStopDisplayListResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<StopDisplayResult> results;

  GetStopDisplayListResModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GetStopDisplayListResModel.fromJson(Map<String, dynamic> json) =>
      GetStopDisplayListResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<StopDisplayResult>.from(
            json["results"].map((x) => StopDisplayResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class StopDisplayResult {
  String id;
  String imei;
  String type;
  bool status;

  StopDisplayResult({
    required this.id,
    required this.imei,
    required this.type,
    required this.status,
  });

  factory StopDisplayResult.fromJson(Map<String, dynamic> json) =>
      StopDisplayResult(
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
