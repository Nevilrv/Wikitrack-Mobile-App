import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/Repo/bus_display_repo.dart';
import 'package:wikitrack/Repo/setting_repo.dart';
import 'package:wikitrack/common/common_snackbar.dart';

import '../../../response_model/get_route_list_res_model.dart';
import '../../../response_model/get_stop_list_res_model.dart';

class BusStopDisplayController extends GetxController {
  ///getStopList

  List<StopResult> stopResult = [];
  List<StopResult> tempStopResult = [];

  ApiResponse _getStopListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getStopListResponse => _getStopListResponse;
  Future getStopListViewModel() async {
    stopResult = [];
    tempStopResult = [];
    update();
    _getStopListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetStopListResModel response = await SettingRepo().getStopList();
      _getStopListResponse = ApiResponse.complete(response);
      log("response==$response");

      stopResult.addAll(response.results);
      tempStopResult.addAll(response.results);

      update();
    } catch (e) {
      _getStopListResponse = ApiResponse.error(message: e.toString());
      log("_getStopListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  searchResult(String value, StateSetter setter) {
    if (value.isEmpty) {
      tempStopResult = stopResult;
    } else {
      tempStopResult = [];
      for (var element in stopResult) {
        if (element.name.toString().toLowerCase().contains(value.toString().toLowerCase())) {
          tempStopResult.add(element);
        }
      }
    }
    update();
    setter(() {});
  }

  List<RouteResult> routeList = [];
  // List<RouteResult>? results=[];

  List<String> times = [];
  bool isLoading = false;

  getRouteList(String stopNo) async {
    Get.back();
    isLoading = true;
    routeList.clear();
    update();
    GetRouteListResModel? getRouteListResModel = await BusDisplayRepo().getRouteList(stopNo, '1');

    if (getRouteListResModel!.results!.isEmpty) {
      isLoading = false;

      update();
      commonSnackBar(message: "No routes found");
    } else {
      log("getRouteListResModel.results--------------> ${getRouteListResModel.results}");

      getRouteListResModel.results!.forEach((element) {
        routeList.add(element);
      });
      getRouteListResModel.results!.forEach((element) {
        element.stopSequence!.forEach((element) {
          if (element.stopId!.stopNo == stopNo) {
            times.add(element.travalTime!);
          }
        });
      });
      log("times--------------> ${times}");

      isLoading = false;
      update();
    }
  }
}
