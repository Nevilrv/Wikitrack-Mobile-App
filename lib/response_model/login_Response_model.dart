// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  int? statusCode;
  String? error;
  Token? token;
  int? userId;
  String? tokenId;

  dynamic profilePic;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? role;
  Oem? oem;
  List<dynamic>? fotaxDevices;
  List<FotaxVehicle>? fotaxVehicle;
  String? fotaxToken;
  List<dynamic>? vehicleModels;

  LoginResponseModel({
    this.statusCode,
    this.error,
    this.token,
    this.userId,
    this.tokenId,
    this.profilePic,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.role,
    this.oem,
    this.fotaxDevices,
    this.fotaxVehicle,
    this.fotaxToken,
    this.vehicleModels,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        statusCode: json["statusCode"],
        error: json["error"],
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
        userId: json["user_id"],
        tokenId: json["token_id"],
        profilePic: json["profile_pic"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        oem: json["oem"] == null ? null : Oem.fromJson(json["oem"]),
        fotaxDevices: json["fotax_devices"] == null ? [] : List<dynamic>.from(json["fotax_devices"]!.map((x) => x)),
        fotaxVehicle: json["fotax_vehicle"] == null
            ? []
            : List<FotaxVehicle>.from(json["fotax_vehicle"]!.map((x) => FotaxVehicle.fromJson(x))),
        fotaxToken: json["fotax_token"],
        vehicleModels: json["vehicle_models"] == null ? [] : List<dynamic>.from(json["vehicle_models"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "error": error,
        "token": token?.toJson(),
        "user_id": userId,
        "token_id": tokenId,
        "profile_pic": profilePic,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "role": role,
        "oem": oem?.toJson(),
        "fotax_devices": fotaxDevices == null ? [] : List<dynamic>.from(fotaxDevices!.map((x) => x)),
        "fotax_vehicle": fotaxVehicle == null ? [] : List<dynamic>.from(fotaxVehicle!.map((x) => x.toJson())),
        "fotax_token": fotaxToken,
        "vehicle_models": vehicleModels == null ? [] : List<dynamic>.from(vehicleModels!.map((x) => x)),
      };
}

class FotaxVehicle {
  String? id;
  String? registrationId;
  String? vin;
  String? segment;
  String? vehicleGroup;
  String? color;
  String? emergencyNo1;
  String? emergencyNo2;
  String? vehicleModel;
  String? subModel;
  String? modelYear;
  dynamic vehicleType;
  dynamic picture;
  int? user;
  String? userType;

  FotaxVehicle({
    this.id,
    this.registrationId,
    this.vin,
    this.segment,
    this.vehicleGroup,
    this.color,
    this.emergencyNo1,
    this.emergencyNo2,
    this.vehicleModel,
    this.subModel,
    this.modelYear,
    this.vehicleType,
    this.picture,
    this.user,
    this.userType,
  });

  factory FotaxVehicle.fromJson(Map<String, dynamic> json) => FotaxVehicle(
        id: json["id"],
        registrationId: json["registration_id"],
        vin: json["vin"],
        segment: json["segment"],
        vehicleGroup: json["vehicle_group"],
        color: json["color"],
        emergencyNo1: json["emergency_no_1"],
        emergencyNo2: json["emergency_no_2"],
        vehicleModel: json["vehicle_model"],
        subModel: json["sub_model"],
        modelYear: json["model_year"],
        vehicleType: json["vehicle_type"],
        picture: json["picture"],
        user: json["user"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "registration_id": registrationId,
        "vin": vin,
        "segment": segment,
        "vehicle_group": vehicleGroup,
        "color": color,
        "emergency_no_1": emergencyNo1,
        "emergency_no_2": emergencyNo2,
        "vehicle_model": vehicleModel,
        "sub_model": subModel,
        "model_year": modelYear,
        "vehicle_type": vehicleType,
        "picture": picture,
        "user": user,
        "user_type": userType,
      };
}

class Oem {
  int? id;
  String? name;
  String? color;

  Oem({
    this.id,
    this.name,
    this.color,
  });

  factory Oem.fromJson(Map<String, dynamic> json) => Oem(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
      };
}

class Token {
  String? refresh;
  String? access;

  Token({
    this.refresh,
    this.access,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
