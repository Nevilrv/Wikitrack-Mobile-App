import 'dart:developer';

import 'package:get/get.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/Repo/setting_repo.dart';
import 'package:wikitrack/response_model/bus_display_res_model.dart';
import 'package:wikitrack/response_model/get_daily_route_trip_res_model.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_time_table_vehicle_list_res_model.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart';
import 'package:wikitrack/response_model/gps_imei_list_res_model.dart';

class SettingController extends GetxController {
  ///getVehicleList

  ApiResponse _getVehicleListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getVehicleListResponse => _getVehicleListResponse;
  Future getVehicleListViewModel() async {
    update();
    _getVehicleListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetVehicleListResModel response = await SettingRepo().getVehicleList();
      _getVehicleListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getVehicleListResponse = ApiResponse.error(message: e.toString());
      log("_loginApiResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///getStopList

  ApiResponse _getStopsListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getStopsListResponse => _getStopsListResponse;
  Future getStopsListViewModel() async {
    update();
    _getStopsListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetVehicleListResModel response = await SettingRepo().getVehicleList();
      _getStopsListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getStopsListResponse = ApiResponse.error(message: e.toString());
      log("_getStopsListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///busDisplayList
  ApiResponse _getBusDisplayListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getBusDisplayListResponse => _getBusDisplayListResponse;
  Future getBusDisplayViewModel() async {
    update();
    _getBusDisplayListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      BusDisplayResModel response = await SettingRepo().getBusDisplayList();
      _getBusDisplayListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getBusDisplayListResponse = ApiResponse.error(message: e.toString());
      log("_getBusDisplayListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///gpsIMEIList
  ApiResponse _getGpsImeiListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getGpsImeiListResponse => _getGpsImeiListResponse;
  Future getGPSImeiListViewModel() async {
    update();
    _getGpsImeiListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GpsImeiListResModel response = await SettingRepo().getGPSImeiList();
      _getGpsImeiListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getGpsImeiListResponse = ApiResponse.error(message: e.toString());
      log("_getGpsImeiListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///getStopDisplayList
  ApiResponse _getStopDisplayListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getStopDisplayListResponse => _getStopDisplayListResponse;
  Future getStopDisplayListViewModel() async {
    update();
    _getGpsImeiListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GpsImeiListResModel response = await SettingRepo().getStopDisplayList();
      _getStopDisplayListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getStopDisplayListResponse = ApiResponse.error(message: e.toString());
      log("_getStopDisplayListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///getTimeTableList
  ApiResponse _getTimeTableListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getTimeTableListResponse => _getTimeTableListResponse;
  Future getTimeTableListViewModel() async {
    update();
    _getTimeTableListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetTimeTableListResModel response = await SettingRepo().getTimeTableList();
      _getTimeTableListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getTimeTableListResponse = ApiResponse.error(message: e.toString());
      log("_getTimeTableListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///getRouteList

  ApiResponse _getRouteListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getRouteListResponse => _getRouteListResponse;
  Future getRouteListViewModel() async {
    update();
    _getRouteListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetRouteListResModel response = await SettingRepo().getRouteList();
      _getRouteListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getRouteListResponse = ApiResponse.error(message: e.toString());
      log("_getRouteListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///getDailyTripRoutesList
  ApiResponse _getDailyTripListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getDailyTripListResponse => _getDailyTripListResponse;
  Future getDailyTripRouteViewModel() async {
    update();
    _getDailyTripListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetDailyRouteTripResModel response = await SettingRepo().getDailyRouteTripRouteList();
      _getDailyTripListResponse = ApiResponse.complete(response);
      log("response==${response}");

      update();
    } catch (e) {
      _getDailyTripListResponse = ApiResponse.error(message: e.toString());
      log("_getDailyTripListResponse==>${e.toString()}");

      update();
    }
    update();
  }
}
