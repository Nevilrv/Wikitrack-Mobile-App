// To parse this JSON data, do
//
//     final getImeitoRegResModel = getImeitoRegResModelFromJson(jsonString);

import 'dart:convert';

GetImeitoRegResModel getImeitoRegResModelFromJson(String str) =>
    GetImeitoRegResModel.fromJson(json.decode(str));

String getImeitoRegResModelToJson(GetImeitoRegResModel data) =>
    json.encode(data.toJson());

class GetImeitoRegResModel {
  String? status;
  String? message;
  List<Datum> data;

  GetImeitoRegResModel({
    this.status,
    this.message,
    required this.data,
  });

  factory GetImeitoRegResModel.fromJson(Map<String, dynamic> json) =>
      GetImeitoRegResModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  LatestDocument latestDocument;

  Datum({
    required this.id,
    required this.latestDocument,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        latestDocument: LatestDocument.fromJson(json["latestDocument"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "latestDocument": latestDocument.toJson(),
      };
}

class LatestDocument {
  String id;
  String packetHeader;
  String venderId;
  String imei;
  dynamic firmwareVersion;
  dynamic alertId;
  dynamic registrationNumber;
  bool gps;
  String date;
  String time;
  double lat;
  double lng;
  String latDirection;
  String lngDirection;
  int speed;
  int heading;
  dynamic altitude;
  dynamic pdop;
  dynamic hdop;
  dynamic operatorName;
  bool ignition;
  dynamic mainPowerStatus;
  double mainInputVoltage;
  dynamic internalBatteryVoltage;
  dynamic emergencyStatus;
  dynamic gsmStrength;
  int mcc;
  int mnc;
  String lac;
  String cellId;
  dynamic digitalInputStatus;
  dynamic digitaloutputStatus;
  dynamic analogInput1;
  dynamic analogInput2;
  dynamic odoMeter;
  dynamic frameNumber;
  dynamic checksum;
  dynamic endCharacter;
  dynamic nmr;
  String createdAt;
  String updatedAt;
  bool isDeleted;
  bool isActive;
  int v;

  LatestDocument({
    required this.id,
    required this.packetHeader,
    required this.venderId,
    required this.imei,
    required this.firmwareVersion,
    required this.alertId,
    required this.registrationNumber,
    required this.gps,
    required this.date,
    required this.time,
    required this.lat,
    required this.lng,
    required this.latDirection,
    required this.lngDirection,
    required this.speed,
    required this.heading,
    required this.altitude,
    required this.pdop,
    required this.hdop,
    required this.operatorName,
    required this.ignition,
    required this.mainPowerStatus,
    required this.mainInputVoltage,
    required this.internalBatteryVoltage,
    required this.emergencyStatus,
    required this.gsmStrength,
    required this.mcc,
    required this.mnc,
    required this.lac,
    required this.cellId,
    required this.digitalInputStatus,
    required this.digitaloutputStatus,
    required this.analogInput1,
    required this.analogInput2,
    required this.odoMeter,
    required this.frameNumber,
    required this.checksum,
    required this.endCharacter,
    required this.nmr,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isActive,
    required this.v,
  });

  factory LatestDocument.fromJson(Map<String, dynamic> json) => LatestDocument(
        id: json["_id"],
        packetHeader: json["packetHeader"],
        venderId: json["venderId"],
        imei: json["imei"],
        firmwareVersion: json["firmwareVersion"],
        alertId: json["alertId"],
        registrationNumber: json["registrationNumber"],
        gps: json["gps"] ?? false,
        date: json["Date"],
        time: json["Time"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        latDirection: json["latDirection"],
        lngDirection: json["lngDirection"],
        speed: json["speed"],
        heading: json["heading"],
        altitude: json["altitude"],
        pdop: json["pdop"],
        hdop: json["hdop"],
        operatorName: json["operatorName"],
        ignition: json["ignition"],
        mainPowerStatus: json["mainPowerStatus"],
        mainInputVoltage: json["mainInputVoltage"]?.toDouble() ?? 0.0,
        internalBatteryVoltage: json["internalBatteryVoltage"],
        emergencyStatus: json["emergencyStatus"],
        gsmStrength: json["gsmStrength"],
        mcc: json["mcc"] ?? 0,
        mnc: json["mnc"] ?? 0,
        lac: json["lac"] ?? "",
        cellId: json["cellId"] ?? "",
        digitalInputStatus: json["digitalInputStatus"],
        digitaloutputStatus: json["digitaloutputStatus"],
        analogInput1: json["analogInput1"],
        analogInput2: json["analogInput2"],
        odoMeter: json["odoMeter"],
        frameNumber: json["frameNumber"],
        checksum: json["checksum"],
        endCharacter: json["endCharacter"],
        nmr: json["NMR"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "packetHeader": packetHeader,
        "venderId": venderId,
        "imei": imei,
        "firmwareVersion": firmwareVersion,
        "alertId": alertId,
        "registrationNumber": registrationNumber,
        "gps": gps,
        "Date": date,
        "Time": time,
        "lat": lat,
        "lng": lng,
        "latDirection": latDirection,
        "lngDirection": lngDirection,
        "speed": speed,
        "heading": heading,
        "altitude": altitude,
        "pdop": pdop,
        "hdop": hdop,
        "operatorName": operatorName,
        "ignition": ignition,
        "mainPowerStatus": mainPowerStatus,
        "mainInputVoltage": mainInputVoltage,
        "internalBatteryVoltage": internalBatteryVoltage,
        "emergencyStatus": emergencyStatus,
        "gsmStrength": gsmStrength,
        "mcc": mcc,
        "mnc": mnc,
        "lac": lac,
        "cellId": cellId,
        "digitalInputStatus": digitalInputStatus,
        "digitaloutputStatus": digitaloutputStatus,
        "analogInput1": analogInput1,
        "analogInput2": analogInput2,
        "odoMeter": odoMeter,
        "frameNumber": frameNumber,
        "checksum": checksum,
        "endCharacter": endCharacter,
        "NMR": nmr,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "__v": v,
      };
}
