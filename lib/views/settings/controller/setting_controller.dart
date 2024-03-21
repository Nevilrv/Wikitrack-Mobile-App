import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/Repo/setting_repo.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/response_model/bus_display_res_model.dart' as busList;
import 'package:wikitrack/response_model/create_time_table_id_res_model.dart';
import 'package:wikitrack/response_model/dailt_route_trip_Response_model.dart';
import 'package:wikitrack/response_model/dailytripregister_response_model.dart' as bus;
import 'package:wikitrack/response_model/get_bus_time_table_res_model.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_display_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_list_res_model.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart' as VehicleList;
import 'package:wikitrack/response_model/gps_imei_list_res_model.dart' as gpsList;

import '../../../Services/base_service.dart';

class SettingController extends GetxController {
  TextEditingController travelTime = TextEditingController();
  TimeOfDay? selectedTime;
  TextEditingController searchController = TextEditingController();
  TextEditingController stopDevice = TextEditingController();
  TextEditingController stop = TextEditingController();

  String stopId = "";
  String? selectedRouteId;
  String? selectedRouteNo;

  ///

  TextEditingController stopNo = TextEditingController();
  TextEditingController stopName = TextEditingController();

  TextEditingController latLangController = TextEditingController();
  String stopDisplayId = "";

  ///

  TextEditingController routeName = TextEditingController();
  TextEditingController routeNo = TextEditingController();
  TextEditingController direction = TextEditingController();

  DateTime selectedDate = DateTime.now();

  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  TextEditingController chasisId = TextEditingController();
  TextEditingController imeiId = TextEditingController();
  String busDisplayDeviceId = '';
  TextEditingController regNo = TextEditingController();
  TextEditingController gpsId = TextEditingController();
  String gpsDeviceId = '';
  String searchId = '';

  get results => null;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    update();
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime!);
      travelTime.text = formattedTimeOfDay.toString();
    }

    update();
  }

  clearAddStopSeq() {
    stopId = "";
    stop.clear();
    stopDevice.clear();
    travelTime.clear();
  }

  clearAddNewStop() {
    stopDevice.clear();
    latLangController.clear();
    stopNo.clear();
    stopName.clear();
  }

  clearRoute() {
    direction.clear();
    routeName.clear();
    routeNo.clear();
  }

  ///getVehicleList
  var lat;
  var long;

  /// Search bus list
  searchBusDisplayResult(String value) {
    if (value.isEmpty) {
      busResult = allBusResult;
    } else {
      busResult = [];
      for (var element in allBusResult) {
        if (element.imei.toString().toLowerCase().contains(value.toString().toLowerCase())) {
          busResult.add(element);
        }
      }
    }
    update();
  }

  /// Search bus list
  searchGpsDeviceResult(String value) {
    if (value.isEmpty) {
      gpsDeviceResult = allGpsDeviceResult;
    } else {
      gpsDeviceResult = [];
      for (var element in allGpsDeviceResult) {
        if (element.imei.toString().toLowerCase().contains(value.toString().toLowerCase())) {
          gpsDeviceResult.add(element);
        }
      }
    }
    update();
  }

  /// Search getVehicleList
  searchStopResult(String value) {
    if (value.isEmpty) {
      searchData = allData;
    } else {
      searchData = [];
      for (var element in allData) {
        if (element.busDisplay != null) {
          if (element.busDisplay!.imei.toString().toLowerCase().contains(value.toString().toLowerCase())) {
            searchData.add(element);
          }
        }
      }
    }
    update();
  }

  searchStop(String value) {
    if (value.isEmpty) {
      stopResult = tempStopResult;
    } else {
      stopResult = [];
      for (var element in tempStopResult) {
        if (element.name.toString().toLowerCase().contains(value.toString().toLowerCase())) {
          stopResult.add(element);
        }
      }
    }
    update();
  }

  searchStopDisplayResult(String value) {
    if (value.isEmpty) {
      stopDisplayResult = tempStopDisplayResult;
    } else {
      stopDisplayResult = [];
      for (var element in tempStopDisplayResult) {
        if (element.imei.toString().toLowerCase().contains(value.toString().toLowerCase())) {
          stopDisplayResult.add(element);
        }
      }
    }
    update();
  }

  ///getRouteList

  List<RouteResult> searchDataResults1 = [];
  List<RouteResult> searchDataResults = [];
  List<RouteResult> tempList = [];

  ApiResponse _getRouteListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getRouteListResponse => _getRouteListResponse;
  Future getRouteListViewModel() async {
    searchDataResults = [];
    tempList = [];
    update();
    _getRouteListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetRouteListResModel response = await SettingRepo().getRouteList("${ApiRouts.routeList}");
      _getRouteListResponse = ApiResponse.complete(response);
      log("response==$response");
      // searchDataResults.addAll(response.results!);
      // tempList.addAll(response.results!);
      response.results!.forEach((element) {
        searchDataResults1.add(element);
        bool hasThreeID = searchDataResults.any((mapTested) => mapTested.routeNo == element.routeNo);
        if (hasThreeID == true) {
        } else {
          searchDataResults.add(element);
          tempList.add(element);
          // bool hasThreeID = searchDataResults.any((mapTested) => mapTested.routeNo == element.routeNo);
        }
        log("element.routeNo--------------> ${element.routeNo}  ${hasThreeID}");
      });
      // response.results!.forEach((element) {
      //   if (element.direction == "1") {
      //     // searchDataResults.add(element);
      //     tempList.add(element);
      //   }
      // });

      update();
    } catch (e) {
      _getRouteListResponse = ApiResponse.error(message: e.toString());
      log("_getRouteListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  searchResult(String value) {
    if (value.isEmpty) {
      searchDataResults = tempList;
    } else {
      searchDataResults = [];
      for (var element in tempList) {
        if (element.routeNo.toString().toLowerCase().contains(value.toString().toLowerCase())) {
          searchDataResults.add(element);
        }
      }
    }
    update();
  }

  setRouteId(String value) {
    selectedRouteId = value;
    update();
  }

  /// ========================================== Route Management =======================================================

  ///Create Route
  ApiResponse _createRouteResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get createRouteResponse => _createRouteResponse;
  Future createRouteViewModel({required Map<String, dynamic> body}) async {
    update();
    _createRouteResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      var response = await SettingRepo().createRouteRepo(body: body);
      _createRouteResponse = ApiResponse.complete(response);
      log("_createRouteResponse==$response");

      update();
    } catch (e) {
      _createRouteResponse = ApiResponse.error(message: e.toString());
      log("_createRouteResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///Create Stop Stop
  ApiResponse _createStopResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get createStopResponse => _createStopResponse;
  Future createStopViewModel({required Map<String, dynamic> body}) async {
    update();
    _createStopResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      var response = await SettingRepo().createStopRepo(body: body);
      _createStopResponse = ApiResponse.complete(response);
      log("_createStopResponse==$response");

      update();
    } catch (e) {
      _createStopResponse = ApiResponse.error(message: e.toString());
      log("_createStopResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///Create Stop Stop Sequence
  ApiResponse _createStopSeqResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get createStopSeqResponse => _createStopSeqResponse;
  Future createStopSeqViewModel({required Map<String, dynamic> body}) async {
    update();
    _createStopSeqResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      var response = await SettingRepo().createStopSequence(body: body);
      _createStopSeqResponse = ApiResponse.complete(response);
      log("_createStopSeqResponse==$response");

      update();
    } catch (e) {
      _createStopSeqResponse = ApiResponse.error(message: e.toString());
      log("_createStopSeqResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///getStopDisplayList

  List<StopDisplayResult> stopDisplayResult = [];
  List<StopDisplayResult> tempStopDisplayResult = [];
  ApiResponse _getStopDisplayListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getStopDisplayListResponse => _getStopDisplayListResponse;
  Future getStopDisplayListViewModel() async {
    stopDisplayResult = [];
    tempStopDisplayResult = [];
    update();
    _getStopDisplayListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetStopDisplayListResModel response = await SettingRepo().getStopDisplayList();
      _getStopDisplayListResponse = ApiResponse.complete(response);
      log("response==$response");

      stopDisplayResult.addAll(response.results);
      tempStopDisplayResult.addAll(response.results);

      update();
    } catch (e) {
      _getStopDisplayListResponse = ApiResponse.error(message: e.toString());
      log("_getStopDisplayListResponse==>${e.toString()}");

      update();
    }
    update();
  }

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

  /// ========================================== Vehicle Management =======================================================

  /// Create Vehicle
  ApiResponse _createVehicleResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get createVehicleResponse => _createVehicleResponse;
  Future createVehicleRouteViewModel({required Map<String, String> body}) async {
    update();
    _createVehicleResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      var response = await SettingRepo().createVehicle(body: body, imagePath: pickedImage?.path ?? '');
      _createVehicleResponse = ApiResponse.complete(response);

      getVehicleListViewModel();
      Get.back();
      commonSnackBar(message: 'Vehicle Created Successfully');
      log("<==response==>$response");

      update();
    } catch (e) {
      _createVehicleResponse = ApiResponse.error(message: e.toString());
      log("_createVehicleResponse==>${e.toString()}");
      update();
    }
    update();
  }

  /// Image picker
  pickGalleryImage({int? index}) async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = image;
      // Uint8List bytes = await pickedImage!.readAsBytes();
      //
      // pickedImageBase64 = base64.encode(bytes);
      // pickedImageExtension = pickedImage!.name.split('.').last;
      update();
    }
  }

  ///updateVehicle
  ApiResponse _updateVehicleResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get updateVehicleResponse => _updateVehicleResponse;
  Future updateVehicleRouteViewModel(
      {required Map<String, String> body, required String uuid, required String vehicleImage}) async {
    update();
    _updateVehicleResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      var response = await SettingRepo().updateVehicle(body: body, uuid: uuid, vehicleImage: vehicleImage);
      _updateVehicleResponse = ApiResponse.complete(response);

      getVehicleListViewModel();
      commonSnackBar(message: 'Details Updated Successfully');
      log("<==response==>$response");

      update();
    } catch (e) {
      _updateVehicleResponse = ApiResponse.error(message: e.toString());
      log("_updateVehicleResponse==>${e.toString()}");
      update();
    }
    update();
  }

  VehicleList.GetVehiclesListResModel? response;
  List<VehicleList.Result> searchData = [];
  List<VehicleList.Result> allData = [];
  List<VehicleList.Result> busRegister = [];
  ApiResponse _getVehicleListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getVehicleListResponse => _getVehicleListResponse;
  Future getVehicleListViewModel() async {
    searchData = [];
    allData = [];
    update();
    _getVehicleListResponse = ApiResponse.loading(message: 'Loading');

    update();

    response = await SettingRepo().getVehicleList();

    _getVehicleListResponse = ApiResponse.complete(response);
    busRegister = response!.results!;
    log("response==$response");

    searchData.addAll(response?.results ?? []);
    allData.addAll(response?.results ?? []);

    update();
  }

  ///gpsIMEIList

  List<gpsList.Result> gpsDeviceResult = [];
  List<gpsList.Result> allGpsDeviceResult = [];

  ApiResponse _getGpsImeiListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getGpsImeiListResponse => _getGpsImeiListResponse;
  Future getGPSImeiListViewModel() async {
    gpsDeviceResult = [];
    allGpsDeviceResult = [];
    update();
    _getGpsImeiListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      gpsList.GpsImeiListResModel response = await SettingRepo().getGPSImeiList();
      _getGpsImeiListResponse = ApiResponse.complete(response);
      log("response==$response");
      gpsDeviceResult.addAll(response.results);
      allGpsDeviceResult.addAll(response.results);

      update();
    } catch (e) {
      _getGpsImeiListResponse = ApiResponse.error(message: e.toString());
      log("_getGpsImeiListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  ///busDisplayList

  List<busList.Result> busResult = [];
  List<busList.Result> allBusResult = [];
  ApiResponse _getBusDisplayListResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getBusDisplayListResponse => _getBusDisplayListResponse;
  Future getBusDisplayViewModel() async {
    busResult = [];
    allBusResult = [];
    update();
    _getBusDisplayListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      busList.BusDisplayResModel response = await SettingRepo().getBusDisplayList();
      _getBusDisplayListResponse = ApiResponse.complete(response);
      log("response=getBusDisplayViewModel=$response");

      busResult.addAll(response.results);
      allBusResult.addAll(response.results);
      update();
    } catch (e) {
      _getBusDisplayListResponse = ApiResponse.error(message: e.toString());
      log("_getBusDisplayListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  clearController() {
    chasisId.clear();
    regNo.clear();
    imeiId.clear();
    gpsId.clear();
    pickedImage = null;
    update();
  }

  /// ========================================== Daily Trip Management =======================================================

  /// Create time slot

  ApiResponse _createTimeSlotResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get createTimeSlotResponse => _createTimeSlotResponse;
  Future createTimeSlotViewModel({required Map<String, dynamic> body}) async {
    update();
    _createTimeSlotResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      var response = await SettingRepo().createTimeSlotRepo(
        body: body,
      );
      _createTimeSlotResponse = ApiResponse.complete(response);

      commonSnackBar(message: 'Time Slot Created Successfully');
      log("<==response==>$response");

      update();
    } catch (e) {
      _createTimeSlotResponse = ApiResponse.error(message: e.toString());
      log("_createVehicleResponse==>${e.toString()}");
      update();
    }
    update();
  }

  // ///daily trip
  //
  // List<bus.CreateRegisterResult> busRegister = [];
  //
  // ApiResponse _dailyTripRegisterResponse =
  //     ApiResponse.initial(message: 'Initialization');
  //
  // ApiResponse get dailyTripRegisterResponse => _dailyTripRegisterResponse;
  // Future dailyTripRegisterViewModel() async {
  //   update();
  //   _dailyTripRegisterResponse = ApiResponse.loading(message: 'Loading');
  //
  //   update();
  //   try {
  //     bus.DailyTripRegisterResponseModel response =
  //         await SettingRepo().dailyTripRegister();
  //     _dailyTripRegisterResponse = ApiResponse.complete(response);
  //
  //     log("response=register=$response");
  //     log("response=register=${response.results}");
  //     busRegister = response.results!;
  //
  //     update();
  //   } catch (e) {
  //     _dailyTripRegisterResponse = ApiResponse.error(message: e.toString());
  //     log("register==>${e.toString()}");
  //
  //     update();
  //   }
  //   update();
  // }

  ///

  List<DailyTripManagementResult> data = [];

  ApiResponse _dailyTripManagementResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get dailyTripManagementResponse => _dailyTripManagementResponse;
  Future dailyTripManagementViewModel({String? routeId, String? direction, String? day}) async {
    update();

    _dailyTripManagementResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      DailyRouteTripResponseModel response =
          await SettingRepo().dailyTripManagementRepo(day: day, direction: direction, routeId: routeId);
      _dailyTripManagementResponse = ApiResponse.complete(response);
      data = response.results!;

      log("_dailyTripManagementResponse=register=$response");
      log("_dailyTripManagementResponse=register=${response.results}");
      update();
    } catch (e) {
      _dailyTripManagementResponse = ApiResponse.error(message: e.toString());
      log("_dailyTripManagementResponse==>${e.toString()}");

      update();
    }
    update();
  }

  bool isForward = false;

  changeIsForward() {
    isForward = !isForward;
    update();
  }

  bool isForward1 = false;

  changeIsForward1() {
    isForward1 = !isForward1;
    update();
  }

  /// ========================================== BUS TIME TABLE =======================================================

  isVisible(index) {
    busTimeTableData.first.daySlot![index].isVisible = !busTimeTableData.first.daySlot![index].isVisible;
    update();
  }

  List<GetBusTimeTable> busTimeTableData = [];
  ApiResponse _getBusTimeTableResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getBusTimeTableResponse => _getBusTimeTableResponse;
  Future busTimeTableViewModel({String? routeId, String? direction}) async {
    update();
    _getBusTimeTableResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetBusTimeTableResModel response = await SettingRepo().busTimeTableRepo(direction: direction, routeId: routeId);
      _getBusTimeTableResponse = ApiResponse.complete(response);
      busTimeTableData = response.results!;
      log("_getBusTimeTableResponse=register=$response");
      log("_getBusTimeTableResponse=register=${response.results}");
      update();
    } catch (e) {
      _getBusTimeTableResponse = ApiResponse.error(message: e.toString());
      log("_getBusTimeTableResponse==>${e.toString()}");

      update();
    }
    update();
  }

  /// Create bus time slot

  ApiResponse _createBusTimeSlotResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get createBusTimeSlotResponse => _createBusTimeSlotResponse;
  Future createBusTimeSlotViewModel({required Map<String, dynamic> body}) async {
    update();
    _createBusTimeSlotResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      var response = await SettingRepo().createBusTimeSlotRepo(body: body);
      _createBusTimeSlotResponse = ApiResponse.complete(response);

      log('response==========>>>>>${response}');

      commonSnackBar(message: 'Time Slot Created Successfully');
      log("<==response==>$response");

      update();
    } catch (e) {
      _createBusTimeSlotResponse = ApiResponse.error(message: e.toString());
      log("_createVehicleResponse==>${e.toString()}");
      update();
    }
    update();
  }

  /// Create bus day slot

  ApiResponse _createBusDaySlotResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get createBusDaySlotResponse => _createBusDaySlotResponse;
  Future createBusDaySlotViewModel({required Map<String, dynamic> body}) async {
    update();
    _createBusDaySlotResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      var response = await SettingRepo().createBusDaySlotRepo(body: body);
      _createBusDaySlotResponse = ApiResponse.complete(response);

      // commonSnackBar(message: 'Day Slot Created Successfully');
      log("<==response==>$response");

      update();
    } catch (e) {
      _createBusDaySlotResponse = ApiResponse.error(message: e.toString());
      log("_createVehicleResponse==>${e.toString()}");
      update();
    }
    update();
  }

  var timeTableId = "";
  Future<void> createTimeTable({Map<String, dynamic>? body}) async {
    var response = await SettingRepo().createTimeTable(body: body!);

    CreateTimeTableIdResModel createTimeTableIdResModel = CreateTimeTableIdResModel.fromJson(jsonDecode(response));
    log("createTimeTableIdResModel--------------> ${createTimeTableIdResModel.id}");
    timeTableId = createTimeTableIdResModel.id!;
    update();
  }
}
