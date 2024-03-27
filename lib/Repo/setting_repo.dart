import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as m;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wikitrack/Services/api_service.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/response_model/bus_display_res_model.dart';
import 'package:wikitrack/response_model/dailt_route_trip_Response_model.dart';
import 'package:wikitrack/response_model/get_bus_time_table_res_model.dart';
import 'package:wikitrack/response_model/get_daily_route_trip_res_model.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_display_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_list_res_model.dart';
import 'package:wikitrack/response_model/get_time_table_vehicle_list_res_model.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart';
import 'package:wikitrack/response_model/gps_imei_list_res_model.dart';

class SettingRepo {
  ///getVehicleList
  Future<dynamic> getVehicleList() async {
    try {
      var response = await APIService()
          .getResponse(url: ApiRouts.vehicleList, apitype: APIType.aGet);
      log('response $response');

      GetVehiclesListResModel getVehicleListResModel =
          GetVehiclesListResModel.fromJson(response);

      return getVehicleListResModel;
    } catch (e) {
      log("GetVehicleListResModel-----ERROR===$e");
    }
  }

  ///getVehicleList
  Future<dynamic> getStopList() async {
    try {
      var response = await APIService()
          .getResponse(url: ApiRouts.stopsList, apitype: APIType.aGet);
      log('response $response');

      GetStopListResModel getStopListResModel =
          GetStopListResModel.fromJson(response);

      return getStopListResModel;
    } catch (e) {
      log("GetStopListResModel-----ERROR===$e");
    }
  }

  ///busDisplayList
  Future<dynamic> getBusDisplayList() async {
    try {
      var response = await APIService()
          .getResponse(url: ApiRouts.busDisplayList, apitype: APIType.aGet);
      log('response $response');

      BusDisplayResModel busDisplayResModel =
          BusDisplayResModel.fromJson(response);

      return busDisplayResModel;
    } catch (e) {
      log("busDisplayResModel-----ERROR===$e");
    }
  }

  ///gpsImeiList
  Future<dynamic> getGPSImeiList() async {
    try {
      var response = await APIService()
          .getResponse(url: ApiRouts.gpsImeiList, apitype: APIType.aGet);
      log('response $response');

      GpsImeiListResModel gpsImeiListResModel =
          GpsImeiListResModel.fromJson(response);

      return gpsImeiListResModel;
    } catch (e) {
      log("gpsImeiListResModel-----ERROR===$e");
    }
  }

  ///getStopDisplayList
  Future<dynamic> getStopDisplayList() async {
    try {
      var response = await APIService()
          .getResponse(url: ApiRouts.stopDisplayList, apitype: APIType.aGet);
      log('response $response');

      GetStopDisplayListResModel getStopDisplayListResModel =
          GetStopDisplayListResModel.fromJson(response);

      return getStopDisplayListResModel;
    } catch (e) {
      log("getStopDisplayListResModel-----ERROR===$e");
    }
  }

  ///getTimeTableList
  Future<dynamic> getTimeTableList() async {
    try {
      var response = await APIService()
          .getResponse(url: ApiRouts.getTimeTableList, apitype: APIType.aGet);
      log('response $response');

      GetTimeTableListResModel getTimeTableListResModel =
          GetTimeTableListResModel.fromJson(response);

      return getTimeTableListResModel;
    } catch (e) {
      log("getTimeTableListResModel-----ERROR===$e");
    }
  }

  ///getRouteList
  Future<dynamic> getRouteList(String url) async {
    try {
      var response =
          await APIService().getResponse(url: url, apitype: APIType.aGet);
      log('response $response');

      GetRouteListResModel getRouteListResModel =
          GetRouteListResModel.fromJson(response);

      return getRouteListResModel;
    } catch (e) {
      log("getRouteListResModel-----ERROR===$e");
    }
  }

  ///dailyRouteTripRoutesList
  bool isLoading = false;
  Future<dynamic> getDailyRouteTripRouteList(
      {String? routeNo, String? direction, String? day}) async {
    try {
      log("${ApiRouts.getDailyRouteTripFilter}--------------> ${ApiRouts.getDailyRouteTripFilter}route_no=$routeNo&direction=$direction}");

      var response = await APIService().getResponse(
          url:
              "${ApiRouts.getDailyRouteTripFilter}route_no=$routeNo&direction=$direction",
          apitype: APIType.aGet);
      log('response>getDailyRouteTripFilter>>> $response');

      GetDailyRouteTripResModel getDailyRouteTripResModel =
          GetDailyRouteTripResModel.fromJson(response);

      return getDailyRouteTripResModel;
    } catch (e) {
      log("getDailyRouteTripResModel-----ERROR===$e");
      return null;
    }
  }

  Future<dynamic> createStopSequence(
      {required Map<String, dynamic> body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createStopSeq),
        body: jsonEncode(body),
      );

      return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
  }

  Future<dynamic> createStopRepo({required Map<String, dynamic> body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createStop),
        body: jsonEncode(body),
      );

      return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
  }

  Future<dynamic> createRouteRepo({required Map<String, dynamic> body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createRoutes),
        body: jsonEncode(body),
      );

      return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new m.Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  Future<dynamic> updateVehicle(
      {required Map<String, String> body,
      required String uuid,
      required String vehicleImage}) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.MultipartRequest(
        "PUT",
        Uri.parse('${ApiRouts.updateVehicle}$uuid/'),
      );

      log('--------${Uri.parse('${ApiRouts.updateVehicle}$uuid/')}');

      request.headers.addAll(headers);
      request.fields.addAll(body);
      log("vehicleImage--------------> ${vehicleImage}");

      if (vehicleImage == "") {
        File file = await urlToFile(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo1kplxuW3G9gRB4FmZCrRSQX4L4eGgGCehg&usqp=CAU');
        log("file--------------> ${file}");
        request.files.add(
          await http.MultipartFile.fromPath('vehicle_img', file.path),
        );
      } else {
        File file = await urlToFile(vehicleImage);
        log("file--------------> ${file}");
        request.files.add(
          await http.MultipartFile.fromPath('vehicle_img', file.path),
        );
      }

      http.StreamedResponse response = await request.send();

      log('----response-----${response.statusCode}');

      return response;
    } catch (e) {
      log("updateVehicleResponse-----ERROR===$e");
    }
  }

  ///create Vehicle
  Future<dynamic> createVehicle(
      {required Map<String, String> body, required String imagePath}) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiRouts.createVehicle),
      );

      request.headers.addAll(headers);
      request.fields.addAll(body);

      request.files.add(
        await http.MultipartFile.fromPath('vehicle_img', imagePath),
      );

      http.StreamedResponse response = await request.send();

      log('----response------${response.statusCode}');

      return response;
    } catch (e) {
      log("updateVehicleResponse-----ERROR===$e");
    }
  }

  ///bus register
  // Future<dynamic> dailyTripRegister() async {
  //   try {
  //     var response = await APIService()
  //         .getResponse(url: ApiRouts.dailyTripRegister, apitype: APIType.aGet);
  //     log('dailyTripRegister  $response');
  //
  //     DailyTripRegisterResponseModel dailyTripRegisterResponseModel =
  //         DailyTripRegisterResponseModel.fromJson(response);
  //
  //     return dailyTripRegisterResponseModel;
  //   } catch (e) {
  //     log("dailyTripRegisterResponseModel-----ERROR===$e");
  //   }
  // }

  ///create time slot

  Future<dynamic> createTimeSlotRepo(
      {required Map<String, dynamic> body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createTimeSlot),
        body: jsonEncode(body),
      );
      log('result.body::::::::::::::::::::==========>>>>>>>>>>>${result.body}');
      return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
  }

  Future<dynamic> dailyTripManagementRepo(
      {String? routeId, String? direction, String? day}) async {
    try {
      var response = await APIService().getResponse(
          url:
              "${ApiRouts.dailyRouteTripList}?route_no=$routeId&direction=$direction&day=$day",
          apitype: APIType.aGet);
      log('dailyRouteTripResponseModel  $response');

      DailyRouteTripResponseModel dailyRouteTripResponseModel =
          DailyRouteTripResponseModel.fromJson(response);

      return dailyRouteTripResponseModel;
    } catch (e) {
      log("dailyRouteTripResponseModel-----ERROR===$e");
    }
  }

  Future<dynamic> busTimeTableRepo({String? routeId, String? direction}) async {
    try {
      var response = await APIService().getResponse(
          url:
              "http://134.209.145.234/api/v1/vehicles/timetable/list/?route_no=$routeId&direction=$direction",
          apitype: APIType.aGet);
      log('busTimeTableResModel  $response');

      GetBusTimeTableResModel busTimeTableResModel =
          GetBusTimeTableResModel.fromJson(response);

      return busTimeTableResModel;
    } catch (e) {
      log("busTimeTableResModel-----ERROR===$e");
    }
  }

  ///create bus time slot

  Future<dynamic> createBusTimeSlotRepo(
      {required Map<String, dynamic> body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createBusTimeSlot),
        body: jsonEncode(body),
      );
      log('result.body::::::::::::::::::::==========>>>>>>>>>>>${result.body}');
      return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
  }

  ///create bus time slot

  Future<dynamic> createBusDaySlotRepo(
      {required Map<String, dynamic> body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createBusDaySlot),
        body: jsonEncode(body),
      );
      log('result.body::::::::::::::::::::==========>>>>>>>>>>>${result.body}');
      return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
  }

  Future<dynamic> createTimeTable({required Map<String, dynamic> body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createTimeTable),
        body: jsonEncode(body),
      );
      log('result.body::::::::::::::::::::==========>>>>>>>>>>>${result.body}');
      return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
  }
}
