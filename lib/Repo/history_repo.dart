import 'dart:developer';

import 'package:wikitrack/Services/api_service.dart';
import 'package:wikitrack/response_model/dailt_route_trip_Response_model.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart';

import '../Services/base_service.dart';

class HistoryRepo {
  ///getRouteList
  Future<GetRouteListResModel?> getRouteList() async {
    try {
      log("1111111111url--------------> ${ApiRouts.routeList}");

      var response = await APIService().getResponse(url: "${ApiRouts.routeList}", apitype: APIType.aGet);
      log('response============== ${response}');

      GetRouteListResModel getRouteListResModel = GetRouteListResModel.fromJson(response);

      return getRouteListResModel;
    } catch (e) {
      log("getRouteListResModel-----ERROR===$e");
    }
    return null;
  }

  ///getVehicleList
  Future<dynamic> getVehicleList() async {
    try {
      var response = await APIService().getResponse(url: ApiRouts.vehicleList, apitype: APIType.aGet);
      log('response $response');

      GetVehiclesListResModel getVehicleListResModel = GetVehiclesListResModel.fromJson(response);

      return getVehicleListResModel;
    } catch (e) {
      log("GetVehicleListResModel-----ERROR===$e");
    }
  }

  Future<dynamic> dailyTripManagementRepo({String? url}) async {
    log("url--------------> ${url}");

    try {
      var response = await APIService().getResponse(url: "$url", apitype: APIType.aGet);
      log('dailyRouteTripResponseModel  $response');

      DailyRouteTripResponseModel dailyRouteTripResponseModel = DailyRouteTripResponseModel.fromJson(response);

      return dailyRouteTripResponseModel;
    } catch (e) {
      log("dailyRouteTripResponseModel-----ERROR===$e");
    }
  }

  Future<dynamic> getVehicleRouteTrip({String? url}) async {
    log("URL++++++++--------------> ${url}");

    try {
      var response = await APIService().getResponse(url: url!, apitype: APIType.aGet);
      log('getVehicleRouteTrip  $response');

      GetVehiclesListResModel getVehiclesListResModel = GetVehiclesListResModel.fromJson(response);

      return getVehiclesListResModel;
    } catch (e) {
      log("getVehicleRouteTrip-----ERROR===$e");
    }
  }

  Future<GetRouteListResModel?> getVehicleRoutes(String stopNo, String direction) async {
    try {
      log("1111111111url--------------> ${ApiRouts.routeList}?route_no=$stopNo&direction=$direction}");

      var response = await APIService()
          .getResponse(url: "${ApiRouts.routeList}?stop_no=$stopNo&direction=$direction", apitype: APIType.aGet);
      log('response============== ${response}');

      GetRouteListResModel getRouteListResModel = GetRouteListResModel.fromJson(response);

      return getRouteListResModel;
    } catch (e) {
      log("getRouteListResModel-----ERROR===$e");
    }
    return null;
  }
}
