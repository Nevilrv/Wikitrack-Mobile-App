import 'dart:developer';

import 'package:wikitrack/Services/api_service.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/response_model/bus_display_res_model.dart';
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
      var response = await APIService().getResponse(url: ApiRouts.vehicleList, apitype: APIType.aGet);
      log('response $response');

      GetVehicleListResModel getVehicleListResModel = GetVehicleListResModel.fromJson(response);

      return getVehicleListResModel;
    } catch (e) {
      log("GetVehicleListResModel-----ERROR===$e");
    }
  }

  ///getVehicleList
  Future<dynamic> getStopList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.stopsList, apitype: APIType.aGet);
      log('response $response');

      GetStopListResModel getStopListResModel = GetStopListResModel.fromJson(response);

      return getStopListResModel;
    } catch (e) {
      log("GetStopListResModel-----ERROR===$e");
    }
  }

  ///busDisplayList
  Future<dynamic> getBusDisplayList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.busDisplayList, apitype: APIType.aGet);
      log('response $response');

      BusDisplayResModel busDisplayResModel = BusDisplayResModel.fromJson(response);

      return busDisplayResModel;
    } catch (e) {
      log("busDisplayResModel-----ERROR===$e");
    }
  }

  ///gpsImeiList
  Future<dynamic> getGPSImeiList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.gpsImeiList, apitype: APIType.aGet);
      log('response $response');

      GpsImeiListResModel gpsImeiListResModel = GpsImeiListResModel.fromJson(response);

      return gpsImeiListResModel;
    } catch (e) {
      log("gpsImeiListResModel-----ERROR===$e");
    }
  }

  ///getStopDisplayList
  Future<dynamic> getStopDisplayList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.stopDisplayList, apitype: APIType.aGet);
      log('response $response');

      GetStopDisplayListResModel getStopDisplayListResModel = GetStopDisplayListResModel.fromJson(response);

      return getStopDisplayListResModel;
    } catch (e) {
      log("getStopDisplayListResModel-----ERROR===$e");
    }
  }

  ///getTimeTableList
  Future<dynamic> getTimeTableList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.getTimeTableList, apitype: APIType.aGet);
      log('response $response');

      GetTimeTableListResModel getTimeTableListResModel = GetTimeTableListResModel.fromJson(response);

      return getTimeTableListResModel;
    } catch (e) {
      log("getTimeTableListResModel-----ERROR===$e");
    }
  }

  ///getRouteList
  Future<dynamic> getRouteList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.routeList, apitype: APIType.aGet);
      log('response $response');

      GetRouteListResModel getRouteListResModel = GetRouteListResModel.fromJson(response);

      return getRouteListResModel;
    } catch (e) {
      log("getRouteListResModel-----ERROR===$e");
    }
  }

  ///dailyRouteTripRoutesList
  Future<dynamic> getDailyRouteTripRouteList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.dailyRouteTripList, apitype: APIType.aGet);
      log('response $response');

      GetDailyRouteTripResModel getDailyRouteTripResModel = GetDailyRouteTripResModel.fromJson(response);

      return getDailyRouteTripResModel;
    } catch (e) {
      log("getDailyRouteTripResModel-----ERROR===$e");
    }
  }
}
