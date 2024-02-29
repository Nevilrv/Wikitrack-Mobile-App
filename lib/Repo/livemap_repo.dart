import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wikitrack/Services/api_service.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/response_model/create_stop_time_res_model.dart';
import 'package:wikitrack/response_model/daily_trip_route_res_model.dart';
import 'package:wikitrack/response_model/get_imeiToReg_res_model.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';

import '../response_model/get_vehicle_list_res_model.dart';

class LiveMapRepo {
  ///getDailyRouteTrip
  Future<dynamic> getDailyRouteTripFilter() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.getDailyRouteTripFilter, apitype: APIType.aGet);
      log('response getDailyRouteTripFilter ${response}');

      DailyTripRouteResModel dailyTripRouteResModel = DailyTripRouteResModel.fromJson(response);

      return dailyTripRouteResModel;
    } catch (e) {
      log("DailyTripRouteResModel-----ERROR===$e");
    }
  }

  Future<GetImeitoRegResModel?> getImeiToReg({required String body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.getImeiToReg),
        body: body,
      );
      log("result.body--------------> ${result.body}");
      GetImeitoRegResModel getImeitoRegResModel = GetImeitoRegResModel.fromJson(jsonDecode(result.body));

      return getImeitoRegResModel;
      // return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
    return null;
  }

  Future<GetVehiclesListResModel?> getVehicleRouteTrip({required String regNo}) async {
    log('url=============>${ApiRouts.vehicleRouteTrip + regNo}');
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.get(
        headers: headers,
        Uri.parse(ApiRouts.vehicleRouteTrip + regNo),
      );
      log("result.body--------------> ${result.body}");
      GetVehiclesListResModel geVehicleRouteTripResModel = GetVehiclesListResModel.fromJson(jsonDecode(result.body));

      return geVehicleRouteTripResModel;
      // return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
    return null;
  }

  ///getRouteList
  Future<GetRouteListResModel?> getRouteList(String routeNo, String direction) async {
    try {
      log("1111111111url--------------> ${ApiRouts.routeList}?route_no=$routeNo&direction=$direction}");

      var response = await APIService()
          .getResponse(url: "${ApiRouts.routeList}?route_no=$routeNo&direction=$direction", apitype: APIType.aGet);
      log('response============== ${response}');

      GetRouteListResModel getRouteListResModel = GetRouteListResModel.fromJson(response);

      return getRouteListResModel;
    } catch (e) {
      log("getRouteListResModel-----ERROR===$e");
    }
    return null;
  }

  /// Create Stop Actual Time
  Future<CreateStopTimeResModel?> createStopActualTime({required String body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      final result = await http.post(
        headers: headers,
        Uri.parse(ApiRouts.createStopTime),
        body: body,
      );
      log("result.body--------------> ${result.body}");
      CreateStopTimeResModel createStopTimeResModel = CreateStopTimeResModel.fromJson(jsonDecode(result.body));

      return createStopTimeResModel;
      // return result.body;
    } catch (e) {
      log("res-----ERROR===$e");
    }
    return null;
  }
}
