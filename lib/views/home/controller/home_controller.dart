import 'package:get/get.dart';
import 'package:wikitrack/Repo/history_repo.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_list_res_model.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart' as vehicle;

import '../../../Repo/setting_repo.dart';

class HomeController extends GetxController {
  String routesLength = "00";
  String stopsLength = "00";
  String vehicleLength = "00";
  getHomeScreenData() async {
    vehicle.GetVehiclesListResModel? getVehiclesListResModel = await HistoryRepo().getVehicleList();
    if (getVehiclesListResModel!.results!.isNotEmpty) {
      vehicleLength = getVehiclesListResModel.results!.length.toString().padLeft(2, '0');
    }
    update();
    GetStopListResModel getStopListResModel = await SettingRepo().getStopList();
    if (getStopListResModel.results.isNotEmpty) {
      stopsLength = getStopListResModel.results.length.toString().padLeft(2, '0');
    }
    update();
    GetRouteListResModel getRouteListResModel = await SettingRepo().getRouteList('${ApiRouts.routeList}');
    if (getRouteListResModel.results!.isNotEmpty) {
      routesLength = getRouteListResModel.results!.length.toString().padLeft(2, '0');
    }
    update();
  }
}
