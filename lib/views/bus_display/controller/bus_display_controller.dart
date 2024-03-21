import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/Repo/livemap_repo.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_time_by_route_no_res_model.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart' as VehicleList;

import '../../../Apis/api_response.dart';
import '../../../Repo/setting_repo.dart';
import '../../../Services/base_service.dart';
import 'package:http/http.dart' as http;

class BusDisplayController extends GetxController {
  List<VehicleList.Result> allData = [];
  VehicleList.GetVehiclesListResModel? response;
  ApiResponse _getVehicleListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getVehicleListResponse => _getVehicleListResponse;

  Future getVehicleListViewModel() async {
    // log("DateTime.now()--------------> ${DateFormat().add_EEEE().format(DateTime.now())}");

    update();
    allData = [];
    _getVehicleListResponse = ApiResponse.loading(message: 'Loading');

    update();

    response = await SettingRepo().getVehicleList();

    _getVehicleListResponse = ApiResponse.complete(response);
    allData.addAll(response?.results ?? []);
    searchData = allData;
    update();
  }

  String searchId = '';
  int selector = 0;
  bool loading3 = false;
  List<VehicleList.Result> searchData = [];

  /// Search getVehicleList
  searchStopResult(String value) {
    if (value.isEmpty) {
      searchData = allData;
    } else {
      searchData = [];
      for (var element in allData) {
        if (element.busDisplay != null) {
          if (element.regNo.toString().toLowerCase().contains(value.toString().toLowerCase())) {
            searchData.add(element);
          }
        }
      }
    }
    update();
  }

  String lastStop = "";
  String nextStop = "";
  String nextStopTime = "";
  List<StopTimeByRouteNo>? routeBusData = [];
  List<StopSequence> stopSequence = [];

  Future getStopTimeByRouteNo({required String routeNo, required StateSetter setter}) async {
    loading3 = true;
    setter(() {});
    update();
    http.Response response = await http.get(Uri.parse("${ApiRouts.getTimeByRegNo}$routeNo"));
    lastStop = "";
    nextStop = "";
    nextStopTime = "";
    int stopIndex = 0;
    int stopIndex1 = -1;
    log("response--------------> ${response.body}");
    if (response.statusCode == 200) {
      GetStopTimeByRouteNoResModel responsee = GetStopTimeByRouteNoResModel.fromJson(jsonDecode(response.body));
      log("response--------------> ${response.body}");

      routeBusData = responsee.results;
      if (routeBusData![0].stopVehicle != null) {
        lastStop = routeBusData![0].stopVehicle!.stopId!.name!;
        log("routeBusData--------------> ${routeBusData}");
        GetRouteListResModel? getRouteListResModel = await LiveMapRepo().getRouteList(
            routeBusData![0].stopVehicle!.routeId!.routeNo!, routeBusData![0].stopVehicle!.routeId!.direction!);

        if (getRouteListResModel!.results!.isEmpty) {
          loading3 = false;
          update();
          setter(() {});
        } else {
          getRouteListResModel.results!.forEach((element) {
            if (element.stopSequence!.isEmpty) {
              loading3 = false;
              update();
              setter(() {});
            } else {
              element.stopSequence!.forEach((element) {
                log("routeBusData![0].stopVehicle!.stopId!.id--------------> ${routeBusData![0].stopVehicle!.stopId!.id}");
                log("element.stopId!.id--------------> ${element.stopId!.id}");

                if (routeBusData![0].stopVehicle!.stopId!.id == element.stopId!.id) {
                  log("stopIndex--------------> ${stopIndex}");

                  stopIndex1 = stopIndex;
                }
                stopIndex++;
                update();
                setter(() {});
              });
            }
          });

          if (stopIndex1 == getRouteListResModel.results![0].stopSequence!.length) {
            nextStop = getRouteListResModel.results![0].stopSequence![stopIndex1].stopId!.name!;
            nextStopTime = getRouteListResModel.results![0].stopSequence![stopIndex1].travalTime!;
          } else {
            nextStop = getRouteListResModel.results![0].stopSequence![stopIndex1 + 1].stopId!.name!;
            nextStopTime = getRouteListResModel.results![0].stopSequence![stopIndex1 + 1].travalTime!;
          }
        }
      }

      loading3 = false;
      update();
      setter(() {});
      Get.back();
      log("nextStop--------------> ${nextStop}");
      log("nextStopTime--------------> ${nextStopTime}");
      log("lastStop--------------> ${lastStop}");

      // log("getRouteListResModel--------------> ${getRouteListResModel}");
    } else {
      loading3 = false;
      update();
      setter(() {});
    }
  }
}
