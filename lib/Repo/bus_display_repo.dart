import 'dart:developer';

import '../Services/api_service.dart';
import '../Services/base_service.dart';
import '../response_model/get_route_list_res_model.dart';

class BusDisplayRepo {
  ///getRouteList
  Future<GetRouteListResModel?> getRouteList(
      String stopNo, String direction) async {
    try {
      log("1111111111url--------------> ${ApiRouts.routeList}?route_no=$stopNo&direction=$direction}");

      var response = await APIService().getResponse(
          url: "${ApiRouts.routeList}?stop_no=$stopNo&direction=$direction",
          apitype: APIType.aGet);
      log('response============== ${response}');

      GetRouteListResModel getRouteListResModel =
          GetRouteListResModel.fromJson(response);

      return getRouteListResModel;
    } catch (e) {
      log("getRouteListResModel-----ERROR===$e");
    }
    return null;
  }
}
