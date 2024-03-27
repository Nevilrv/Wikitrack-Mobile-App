import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/Repo/livemap_repo.dart';
import 'package:wikitrack/Repo/setting_repo.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/package/core/i_animarker_controller.dart';
import 'package:wikitrack/response_model/create_stop_time_res_model.dart';
import 'package:wikitrack/response_model/get_daily_route_trip_res_model.dart';
import 'package:wikitrack/response_model/get_imeiToReg_res_model.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_time_by_reg_no_res_model.dart'
    as getByRegNo;
import 'package:wikitrack/response_model/get_stop_time_by_route_no_res_model.dart';
import 'package:wikitrack/socket/socket_service.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart'
    as VehicleList;
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:http/http.dart' as http;
import 'package:google_map_marker_animation/google_map_marker_animation.dart';

class LiveMapController extends GetxController {
  double? lat;
  double? long;
  Uint8List? markIcons;

  ///socket listner
  Future<void> getLiveMapDataListener() async {
    markIcons = await getImages(AppImages.vehicleMap, 100);
    getSocketAllAngleOn();
  }

  ///socket emit
  Future<void> getSocketLiveMapData() async {
    SocketConnection.socket!.emit(
      'locationinfo',
      {},
    );
  }

  ///socket on
  getSocketAllAngleOn() {
    SocketConnection.socket!.on("locationinfo", (data) {
      log('locationinfo>>> ${data.runtimeType}');
      log('locationinfo>>> ${data}');
      LatestDocument result;
      if (data.runtimeType == List<dynamic>) {
        result = LatestDocument.fromJson(data[0]);
      } else {
        result = LatestDocument.fromJson(data);
      }

      update();
      log("result--------------> ${jsonEncode(result)}");
      int ind = -1;
      LatLng lng;
      for (var element in allImeiList) {
        log("element.lat--------------> ${element.lat}");
        log("element.lng--------------> ${element.lng}");
        if (element.imei == result.imei) {
          ind = allImeiList.indexOf(element);
        }
      }
      log("ind--------------> ${ind}");

      if (ind != -1) {
        log("ind--------------> ${ind}");
        lng = LatLng(allImeiList[ind].lat, allImeiList[ind].lng);
        log("lng--------------> ${lng.longitude}");
        log("lng--------------> ${lng.latitude}");

        allImeiList.removeAt(ind);
        // markers.removeAt(ind);
        log("allImeiList--------------> b ${allImeiList}");
        update();
        allImeiList.insert(ind, result);
        update();
        log("allImeiList[ind].lat--------------> ${allImeiList[ind].lat}");
        log("allImeiList[ind].lng--------------> ${allImeiList[ind].lng}");
        // markers[ind] = Marker(
        //   // given marker id
        //   markerId: MarkerId("vehicle ${allImeiList[ind].imei.toString()}"),
        //   // given marker icon
        //   icon: BitmapDescriptor.fromBytes(markIcons!),
        //   // given position
        //   position: LatLng(allImeiList[ind].lat, allImeiList[ind].lng),
        //   infoWindow: InfoWindow(
        //     // given title for marker
        //     title: 'vehicle: ${allImeiList[ind].imei}',
        //   ),
        // );
        transition([allImeiList[ind].lat, allImeiList[ind].lng], ind,
            [lng.latitude, lng.longitude]);
        // transition([allImeiList[ind].lat, allImeiList[ind].lng], [lng.latitude, lng.longitude], ind);
        update();
        log("allImeiList--------------> a ${allImeiList}");
      }
      //

      // loadMarkers();
      // loadMarkers();
      // if (data.runtimeType == List<dynamic>) {
      //   LatestDocument result = LatestDocument.fromJson(data[0]);
      //   log("result--------------> ${result}");
      //   int ind = -1;
      //   allImeiList.forEach((element) {
      //     log("element.id--------------> ${element.imei}");
      //     log("result.id--------------> ${result.imei}");
      //     if (element.imei == result.imei) {
      //       ind = allImeiList.indexOf(element);
      //     }
      //   });
      //   log("ind--------------> ${ind}");
      //
      //   if (ind != -1) {
      //     allImeiList.removeAt(ind);
      //     log("allImeiList--------------> b ${allImeiList}");
      //     update();
      //     allImeiList.insert(ind, result);
      //     log("allImeiList--------------> a ${allImeiList}");
      //   }
      //   log("allData--------------> ${allImeiList[ind].lat}");
      //   log("allData--------------> ${allImeiList[ind].lng}");
      // } else {
      //   LatestDocument result = LatestDocument.fromJson(data);
      //   log("result--------------> ${result}");
      //   int ind = -1;
      //   LatLng lng;
      //   allImeiList.forEach((element) {
      //     log("element.id--------------> ${element.imei}");
      //     log("result.id--------------> ${result.imei}");
      //
      //     if (element.imei == result.imei) {
      //       ind = allImeiList.indexOf(element);
      //     }
      //   });
      //   log("ind--------------> ${ind}");
      //
      //   if (ind != -1) {
      //     log("ind--------------> ${ind}");
      //     lng = LatLng(allImeiList[ind].lat, allImeiList[ind].lng);
      //     allImeiList.removeAt(ind);
      //     markers.removeAt(ind);
      //     log("allImeiList--------------> b ${allImeiList}");
      //     update();
      //     allImeiList.insert(ind, result);
      //     transition([allImeiList[ind].lat, allImeiList[ind].lng], [lng.latitude, lng.longitude], ind);
      //     update();
      //     log("allImeiList--------------> a ${allImeiList}");
      //   }
      //   log("allData--------------> ${allImeiList[ind].lat}");
      //   log("allData--------------> ${allImeiList[ind].lng}");
      // }
      // update();

      // update();
      // loadMarkers();
      // update();
    });
  }

  // int numDeltas = 50; //number of delta to devide total distance
  // int delay = 50;
  // int i = 0;
  // transition(List result, List lastResult, int index) {
  //   double? deltaLat;
  //   double? deltaLng;
  //   var position = lastResult;
  //   log("position--------------> ${position}");
  //   log("result--------------> ${result}");
  //
  //   deltaLat = (result[0] - position[0]) / numDeltas;
  //   deltaLng = (result[1] - position[1]) / numDeltas;
  //   moveMarker(position, deltaLat, deltaLng, i, numDeltas, delay, index);
  // }

  // moveMarker(var position, double? deltaLat, double? deltaLng, int i, int numDeltas, int delay, int index) async {
  //   position[0] += deltaLat;
  //   position[1] += deltaLng;
  //   var latlng = LatLng(position[0], position[1]);
  //   log('move marker----------0');
  //
  //   markers.insert(
  //       index,
  //       Marker(
  //         // given marker id
  //         markerId: MarkerId("vehicle ${allImeiList[index].imei.toString()}"),
  //         // given marker icon
  //         icon: BitmapDescriptor.fromBytes(markIcons!),
  //         // given position
  //         position: latlng,
  //         infoWindow: InfoWindow(
  //           // given title for marker
  //           title: 'vehicle: ' + allImeiList[index].imei.toString(),
  //         ),
  //       ));
  //   // markers = {
  //   //   Marker(
  //   //     markerId: MarkerId("movingmarker"),
  //   //     position: latlng,
  //   //     icon: BitmapDescriptor.defaultMarker,
  //   //   )
  //   // };
  //
  //   update();
  //
  //   if (i != numDeltas) {
  //     i++;
  //     Future.delayed(Duration(milliseconds: delay), () {
  //       log('move marker----------1');
  //       moveMarker(position, deltaLat, deltaLng, i, numDeltas, delay, index);
  //       // update();
  //     });
  //     update();
  //   }
  // }

  int vehicleIndex = -1;
  List<LatestDocument> oldAllImeiList = [];
  int numDeltas = 50; //number of delta to devide total distance
  int delay = 50; //milliseconds of delay to pass each delta
  transition(result, int index, positions) {
    var i = 0;
    double? deltaLat;
    double? deltaLng;
    var position = positions;
    deltaLat = (result[0] - position[0]) / numDeltas;
    deltaLng = (result[1] - position[1]) / numDeltas;
    moveMarker(i, deltaLat, deltaLng, position, i);
  }

  moveMarker(
      int i, double? deltaLat, double? deltaLng, List position, int index) {
    position[0] += deltaLat;
    position[1] += deltaLng;
    var latlng = LatLng(position[0], position[1]);
    log("index-indexindex-------------> ${index}");
    markers.removeAt(index);
    markers.insert(
        index,
        Marker(
          // given marker id
          markerId: MarkerId("vehicle ${allImeiList[index].imei.toString()}"),
          // given marker icon
          icon: BitmapDescriptor.fromBytes(markIcons!),
          // given position
          position: latlng,
          infoWindow: InfoWindow(
            // given title for marker
            title: 'vehicle: ' + allImeiList[index].imei.toString(),
          ),
        ));

    update();

    if (i != numDeltas) {
      i++;
      Future.delayed(Duration(milliseconds: delay), () {
        moveMarker(i, deltaLat, deltaLng, position, index);
      });
    }
  }

  ///get vehicle list
  VehicleList.GetVehiclesListResModel? response;
  List<VehicleList.Result> allData = [];
  List<LatestDocument> allImeiList = [];
  List<Marker> markers = <Marker>[];

  // List<Marker> markers = <Marker>[];
  // List<Marker> markers = <Marker>[];
  GetImeitoRegResModel? getImeitoRegResModel;
  ApiResponse _getVehicleListResponse =
      ApiResponse.initial(message: 'Initialization');

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
    var imeiList = [];
    for (var element in allData) {
      if (!imeiList.contains(element.gpsDevice!.imei)) {
        imeiList.add(element.gpsDevice!.imei);
        log("element--------------> ${element.gpsDevice!.imei}");
      }
    }
    log("imeiList--------------> ${imeiList}");

    var body = json.encode({"imei": imeiList, "type": "one"});
    log("body--------------> ${body}");
    if (imeiList.isNotEmpty) {
      getImeitoRegResModel = await LiveMapRepo().getImeiToReg(body: body);
      for (var element in getImeitoRegResModel!.data) {
        allImeiList.add(element.latestDocument!);
      }
    }
    if (allImeiList.isNotEmpty) {
      lat = allImeiList[0].lat;
      long = allImeiList[0].lng;
    }
    GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        // on below line we have given positions of Location 5
        CameraPosition(
      target: LatLng(lat!, long!),
      zoom: 15,
    )));
    log("lat--------------> ${lat}");

    update();
    log("data--------------> ${getImeitoRegResModel!.data}");
    log("allImeiList--------------> ${allImeiList}");
    loadMarkers();
    update();
  }

  ///getDaily route trip
  GetDailyRouteTripResModel? getDailyRouteTripResModel;
  ApiResponse _getDailyRouteTripResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getDailyRouteTripResponse => _getDailyRouteTripResponse;
  bool isLoading1 = false;
  Future getDailyRouteTripViewModel(StateSetter setter) async {
    isLoading1 = true;

    setter(() {});
    update();
    _getDailyRouteTripResponse = ApiResponse.loading(message: 'Loading');
    update();
    getDailyRouteTripResModel = await SettingRepo().getDailyRouteTripRouteList(
        routeNo: selectedRouteId,
        direction: isForward ? '1' : '0',
        day: DateFormat().add_EEEE().format(DateTime.now()));

    _getDailyRouteTripResponse = ApiResponse.complete(response);
    List vehicleIMEIList = [];

    if (getDailyRouteTripResModel != null) {
      for (var element in getDailyRouteTripResModel!.results) {
        if (element.daySlot.isNotEmpty) {
          for (var element1 in element.daySlot) {
            if (element1.day == DateFormat('EEEE').format(DateTime.now())) {
              if (element1.timeSlot.isNotEmpty) {
                for (var element2 in element1.timeSlot) {
                  if (element2.dailyrouteTimeslot.isNotEmpty) {
                    for (var element3 in element2.dailyrouteTimeslot) {
                      vehicleIMEIList.add(element3.vehicle.gpsDevice.imei);
                    }
                  }
                }
              }

              log("element1--------------> ${element1.timeSlot}");
            }
          }
          log("vehicleIMEIList--------------> $vehicleIMEIList");
        }
      }
    }

    var body = json.encode({"imei": vehicleIMEIList, "type": "one"});
    log("body--------------> $body");
    allImeiList.clear();
    routeBusStopsData.clear();
    update();
    getImeitoRegResModel = await LiveMapRepo().getImeiToReg(body: body);
    if (getImeitoRegResModel?.data == null) {
      commonSnackBar(message: "No vehicle found");

      update();
    } else {
      debugPrint(
          'getImeitoRegResModel?.data===>>>${getImeitoRegResModel?.data}');
      for (var element in getImeitoRegResModel!.data) {
        allImeiList.add(element.latestDocument);
      }
      List<int> value = [];
      busData.clear();
      bool isDistanceMatch = false;
      for (var element in allImeiList) {
        log("element>>>${jsonEncode(element)}");

        stopSequence.forEach((element1) async {
          log("element1>>>${jsonEncode(element1)}");

          log("double.parse(element1.stopId!.location!.split(',')[0]--------------> ${double.parse(element1.stopId!.location!.split(',')[0])}");
          log("double.parse(element1.stopId!.location!.split(',')[2]--------------> ${double.parse(element1.stopId!.location!.split(',')[1])}");

          double distanceInMeters = Geolocator.distanceBetween(
              element.lat,
              element.lng,
              double.parse(element1.stopId!.location!.split(',')[0]),
              double.parse(element1.stopId!.location!.split(',')[1]));

          log("distanceInMeters--------------> $distanceInMeters");

          if (distanceInMeters <= 50) {
            String vehicleId = "";
            isDistanceMatch = true;
            for (var element0 in allData) {
              log("element0.gpsDevice?.imei--------------> ${element0.gpsDevice?.imei}");
              log("element.imei--------------> ${element.imei}");

              if (element0.gpsDevice?.imei == element.imei) {
                vehicleId = element0.id ?? "";
                log("vehicleId--------------> ${vehicleId}");
              }
            }

            DateTime current = DateTime.now();

            await createStopTimeViewModel(body: {
              "vehicle": vehicleId,
              "route_id": selRouteId,
              "stop_id": element1.stopId?.id,
              "current_date":
                  "${current.year}-${current.month}-${current.day}T${current.hour}:${current.minute}:${current.second}"
            });
            log("selectedRouteId--------------> ${selectedRouteId}");
          }
          // log("distanceInMeters--------------> ${distanceInMeters}");
          // value.add(distanceInMeters.round());
        });

        // firstNonConsecutive(value, element.id);
        // value.clear();
      }
      if (isDistanceMatch == true) {
        print("IN HERE");
        await getStopTimeByRouteNo(routeNo: selectedRouteId);
      }
      update();
    }
    loadMarkers();
    log("stopSequence.length--------------> ${stopSequence.length}");
    polylineCoordinates.clear();
    polylines.clear();
    int changeIndex = 0;
    for (int i = 0; i < stopSequence.length; i++) {
      if (changeIndex == 0) {
        changeIndex++;
      } else {
        log("changeIndex-------------->${changeIndex - 1} -- ${changeIndex}");

        List data = stopSequence[changeIndex - 1].stopId!.location!.split(',');
        List data1 = stopSequence[changeIndex].stopId!.location!.split(',');
        log("data--------------> ${data}");
        log("data--------------> ${data1}");

        String lat;
        String lat1;
        String lang;
        String lang1;
        if (data.length == 2) {
          lat = data[0];
          lang = data[1];
        } else {
          lat = data[0];
          lang = data[2];
        }
        if (data1.length == 2) {
          lat1 = data1[0];
          lang1 = data1[1];
        } else {
          lat1 = data1[0];
          lang1 = data1[2];
        }
        log("lat--lang------------> ${lat} ${lang}");
        log("lat1--lang1------------> ${lat1} ${lang1}");

        // makers added according to index
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyA_S7GfAh6rJYWQ5X4n4X-3poo3vymuspU',
          PointLatLng(double.parse(lat), double.parse(lang)),
          PointLatLng(double.parse(lat1), double.parse(lang1)),
          travelMode: TravelMode.driving,
        );
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            log("point.latitude--------------> ${point.latitude}");
            log("point.longitude--------------> ${point.longitude}");
          }
        }
        _addPolyLine();
        changeIndex++;
        update();
      }
      log("changeIndex--------------> ${changeIndex}");

      //

      update();
    }
    _addPolyLine();
    isLoading1 = false;
    Get.back();
    setter(() {});
  }

  List<Map<String, dynamic>> busData = [];

  int? firstNonConsecutive(List<int> arr, String busId) {
    var max = arr.reduce((curr, next) => curr > next ? curr : next);
    log('max----------${max}'); // 8 --> Max
    var min = arr.reduce((curr, next) => curr < next ? curr : next);
    var index = arr.indexOf(min);

    busData.add({"busId": busId, "stopIndex": index});
    update();
    log("busData--------------> ${busData}");

    log("min--------------> ${min}");

    return null;
  }

  ///getRouteList
  List<RouteResult> searchDataResults = [];
  List<RouteResult> searchDataResultsAll = [];
  List<RouteResult> tempList = [];
  List<StopSequence> stopSequence = [];

  String selectedRouteId = "";
  String selRouteId = "";
  TextEditingController searchController = TextEditingController();
  ApiResponse _getRouteListResponse =
      ApiResponse.initial(message: 'Initialization');
  ApiResponse get getRouteListResponse => _getRouteListResponse;

  Future getRouteListViewModel() async {
    searchDataResults = [];
    tempList = [];
    update();
    _getRouteListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetRouteListResModel response =
          await SettingRepo().getRouteList('${ApiRouts.routeList}');
      // searchDataResults.addAll(response.results!);
      // tempList.addAll(response.results!);

      response.results!.forEach((element) {
        // searchDataResults.add(element);
        bool hasThreeID = searchDataResults
            .any((mapTested) => mapTested.routeNo == element.routeNo);
        if (hasThreeID == true) {
        } else {
          searchDataResults.add(element);
          tempList.add(element);
          // bool hasThreeID = searchDataResults.any((mapTested) => mapTested.routeNo == element.routeNo);
        }
        log("element.routeNo--------------> ${element.routeNo}  ${hasThreeID}");
      });
      _getRouteListResponse = ApiResponse.complete(response);
      log("response==${jsonEncode(response)}");

      update();
    } catch (e) {
      _getRouteListResponse = ApiResponse.error(message: e.toString());
      log("_getRouteListResponse==>${e.toString()}");

      update();
    }
    update();
  }

  Future getRouteListByDirectionViewModel(
      String stopNo, String direction) async {
    stopSequence.clear();
    update();
    log("${ApiRouts.routeList}--------------> ${ApiRouts.routeList}?route_no=$stopNo&direction=$direction}");

    try {
      GetRouteListResModel response = await SettingRepo().getRouteList(
          '${ApiRouts.routeList}?route_no=$stopNo&direction=$direction');

      if (response.results![0].stopSequence!.isNotEmpty) {
        stopSequence.addAll(response.results![0].stopSequence!);
      }
      // searchDataResults.addAll(response.results!);
      // tempList.addAll(response.results!);
    } catch (e) {}
    update();
  }

  searchResult(String value) {
    if (value.isEmpty) {
      searchDataResults = tempList;
    } else {
      searchDataResults = [];
      for (var element in tempList) {
        if (element.routeNo
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase())) {
          searchDataResults.add(element);
        }
      }
    }
    update();
  }

  setRouteId(String value, String id) {
    selectedRouteId = value;
    selRouteId = id;
    log("selectedRouteId--------------> ${selectedRouteId}");
    log("selRouteId--------------> ${selRouteId}");

    update();
  }

  bool isForward = false;

  changeIsForward() {
    isForward = !isForward;
    update();
  }

  String searchId = '';
  int selector = 0;
  List<VehicleList.Result> searchData = [];

  /// Search getVehicleList
  searchStopResult(String value) {
    if (value.isEmpty) {
      searchData = allData;
    } else {
      searchData = [];
      for (var element in allData) {
        if (element.busDisplay != null) {
          if (element.regNo
              .toString()
              .toLowerCase()
              .contains(value.toString().toLowerCase())) {
            searchData.add(element);
          }
        }
      }
    }
    update();
  }

  VehicleList.GetVehiclesListResModel? geVehicleRouteTripResModel;

  bool loading3 = false;
  bool filterByVehicle = false;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  getVehicleRouteList(String regNo, StateSetter setState1) async {
    String routeNo = '';
    String direction = '';
    loading3 = true;
    allImeiList.clear();
    setState1(() {});
    update();
    List<VehicleList.Result> allData = [];
    geVehicleRouteTripResModel =
        await LiveMapRepo().getVehicleRouteTrip(regNo: regNo);
    allData = geVehicleRouteTripResModel?.results ?? [];

    var imeiList = [];
    for (var element in allData) {
      if (!imeiList.contains(element.gpsDevice!.imei)) {
        imeiList.add(element.gpsDevice!.imei);
        log("element--------------> ${element.gpsDevice!.imei}");
      }
    }
    log("imeiList--------------> ${imeiList}");

    var body = json.encode({"imei": imeiList, "type": "one"});
    log("body--------------> ${body}");
    if (imeiList.isNotEmpty) {
      getImeitoRegResModel = await LiveMapRepo().getImeiToReg(body: body);
      for (var element in getImeitoRegResModel!.data) {
        allImeiList.add(element.latestDocument);
      }
    } else {}
    if (allImeiList.isNotEmpty) {
      lat = allImeiList[0].lat;
      long = allImeiList[0].lng;
    }

    log("lat--------------> ${lat}");

    update();
    log("data--------------> ${getImeitoRegResModel!.data}");
    log("allImeiList--------------> ${allImeiList}");

    if (geVehicleRouteTripResModel?.results?.isNotEmpty ?? false) {
      for (var element in geVehicleRouteTripResModel!.results!) {
        for (var element1 in element.dailyrouteVehicle!) {
          if (element1.timeslot!.dayslot!.day ==
              DateFormat('EEEE').format(DateTime.now())) {
            routeNo = element1.timeslot!.dayslot!.timetable!.route!.routeNo;
            direction = element1.timeslot!.dayslot!.timetable!.route!.direction;
          }
        }
      }

      if (routeNo != "" && direction != "") {
        GetRouteListResModel? getRouteListResModel =
            await LiveMapRepo().getRouteList(routeNo, direction);
        if (getRouteListResModel != null) {
          stopSequence.clear();
          for (var element in getRouteListResModel.results!) {
            stopSequence = element.stopSequence!;

            log("stopSequence--------------> ${stopSequence}");
          }

          stopSequence.sort(
            (a, b) => a.priority!.compareTo(b.priority!),
          );
        } else {
          loading3 = false;
          update();
          commonSnackBar(message: "Routes not found");
        }
      }
    }
    if (stopSequence.isEmpty) {
      loading3 = false;
      setState1(() {});

      update();
      commonSnackBar(message: "Stop not found");
    } else {
      filterByVehicle = true;
      loadMarkers();
      log("stopSequence.length--------------> ${stopSequence.length}");
      polylineCoordinates.clear();
      polylines.clear();
      int changeIndex = 0;
      for (int i = 0; i < stopSequence.length; i++) {
        if (changeIndex == 0) {
          changeIndex++;
        } else {
          log("changeIndex-------------->${changeIndex - 1} -- ${changeIndex}");

          List data =
              stopSequence[changeIndex - 1].stopId!.location!.split(',');
          List data1 = stopSequence[changeIndex].stopId!.location!.split(',');
          log("data--------------> ${data}");
          log("data--------------> ${data1}");

          String lat;
          String lat1;
          String lang;
          String lang1;
          if (data.length == 2) {
            lat = data[0];
            lang = data[1];
          } else {
            lat = data[0];
            lang = data[2];
          }
          if (data1.length == 2) {
            lat1 = data1[0];
            lang1 = data1[1];
          } else {
            lat1 = data1[0];
            lang1 = data1[2];
          }
          log("lat--lang------------> ${lat} ${lang}");
          log("lat1--lang1------------> ${lat1} ${lang1}");

          // makers added according to index
          PolylineResult result =
              await polylinePoints.getRouteBetweenCoordinates(
            'AIzaSyA_S7GfAh6rJYWQ5X4n4X-3poo3vymuspU',
            PointLatLng(double.parse(lat), double.parse(lang)),
            PointLatLng(double.parse(lat1), double.parse(lang1)),
            travelMode: TravelMode.driving,
          );
          if (result.points.isNotEmpty) {
            for (var point in result.points) {
              polylineCoordinates.add(LatLng(point.latitude, point.longitude));
              log("point.latitude--------------> ${point.latitude}");
              log("point.longitude--------------> ${point.longitude}");
            }
          }
          _addPolyLine();
          changeIndex++;
          update();
        }
        log("changeIndex--------------> ${changeIndex}");

        //

        update();
      }

      Get.back();
      loading3 = false;
      update();
      setState1(() {});
    }

    update();
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.primaryColor,
        points: polylineCoordinates,
        width: 3);
    polylines[id] = polyline;
    update();
  }

  ///map methods

  Completer<GoogleMapController> googleMapController = Completer();
  Position? currentPosition;
  bool isLoading = true;

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      // lat = currentPosition!.latitude;
      // long = currentPosition!.longitude;
      update();
      log('currentPosition!.latitude==========>>>>>${currentPosition!.latitude}');
      log('currentPosition!.longitude==========>>>>>${currentPosition!.longitude}');
      // lat = currentPosition!.latitude;
      // long = currentPosition!.longitude;
      isLoading = false;
      update();
    }).catchError((e) {
      isLoading = false;
      update();
      debugPrint("ERROR=========$e");
    });
  }

  Future<bool> handleLocationPermission() async {
    isLoading = true;
    update();
    bool serviceEnabled;
    LocationPermission permission;
    //
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   commonSnackBar(message: 'Location services are disabled. Please enable the services');
    //
    //   return false;
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        commonSnackBar(message: 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      commonSnackBar(
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadMarkers() async {
    markers.clear();
    update();
    log("markers--------------->change}");
    // final Uint8List markIcons = await getImages(AppImages.vehicleMap, 100);
    int index = 0;
    log("allImeiList--------------> ${allImeiList.length}");

    for (int i = 0; i < allImeiList.length; i++) {
      markers.add(Marker(
        // given marker id
        markerId: MarkerId("vehicle ${i.toString()}"),
        // given marker icon
        icon: BitmapDescriptor.fromBytes(markIcons!),
        // given position
        position: LatLng(allImeiList[i].lat, allImeiList[i].lng),
        infoWindow: InfoWindow(
          // given title for marker
          title: 'vehicle: ${allImeiList[i].imei}',
        ),
      ));
      index++;
      update();
    }
    final Uint8List stopsIcons = await getImages(AppImages.busStopMap, 100);
    for (int i = 0; i < stopSequence.length; i++) {
      List data = stopSequence[i].stopId!.location!.split(',');
      String lat;
      String lang;
      if (data.length == 2) {
        lat = data[0];
        lang = data[1];
      } else {
        lat = data[0];
        lang = data[2];
      }
      //
      // makers added according to index
      markers.add(Marker(
        // given marker id
        markerId: MarkerId("Stop ${i.toString()}"),
        // given marker icon
        icon: BitmapDescriptor.fromBytes(stopsIcons),
        // given position
        position: LatLng(double.parse(lat), double.parse(lang)),
        infoWindow: InfoWindow(
          // given title for marker
          title: 'Stop: ' + i.toString(),
        ),
      ));
      update();
    }

    update();

    log("markers--------------> ${markers.length}");
    log("markers--------------> ${markers}");
  }

  /// Create Actual Stop Time
  Future createStopTimeViewModel({required Map<String, dynamic> body}) async {
    log('api call------------');
    http.Response response =
        await http.post(Uri.parse(ApiRouts.createStopTime), body: body);

    log("response.statusCode--------------> ${response.statusCode}");

    if (response.statusCode == 201) {
      log("response-createStopTimeViewModel-------------> ${response.body}");
    } else {
      CreateStopTimeResModel responsee =
          CreateStopTimeResModel.fromJson(jsonDecode(response.body));
    }
  }

  /// Get Stop Time by Reg No
  List<String> busStopDataIds = [];
  Future getStopTimeByRegNo({required String regNo}) async {
    http.Response response =
        await http.get(Uri.parse("${ApiRouts.getTimeByRegNo}$regNo"));

    if (response.statusCode == 200) {
      getByRegNo.GetStopTimeByRegNoResModel responsee =
          getByRegNo.GetStopTimeByRegNoResModel.fromJson(
              jsonDecode(response.body));
      log("response-busStopDataIds-------------> ${response.body}");

      busStopDataIds.clear();

      if (responsee.results?.isNotEmpty ?? false) {
        responsee.results?.forEach((element) {
          busStopDataIds.add(element.stopVehicle?.stopId?.id ?? "");
        });
        update();
      }
    }
  }

  /// Get Stop Time by Route No
  List<StopTimeByRouteNo>? routeBusData = [];
  List<Map<String, dynamic>> routeBusStopsData = [];
  Future getStopTimeByRouteNo({required String routeNo}) async {
    routeBusStopsData.clear();
    DateTime current = DateTime.now();

    http.Response response = await http.get(Uri.parse(
        "${ApiRouts.getTimeByRouteNo}$routeNo&current_date=${current.year}-${current.month}-${current.day}T${current.hour}:${current.minute}:${current.second.toString().padLeft(2, '0')}"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      GetStopTimeByRouteNoResModel responsee =
          GetStopTimeByRouteNoResModel.fromJson(jsonDecode(response.body));
      log("response-getStopTimeByRouteNo-------------> ${response.body}");

      routeBusData = responsee.results;

      log("stopSequence-getStopTimeByRouteNo-------------> ${jsonEncode(stopSequence)}");

      for (var element in stopSequence) {
        if (!routeBusStopsData
            .contains({"stop_id": "${element.stopId?.id}", "count": 0})) {
          routeBusStopsData
              .add({"stop_id": "${element.stopId?.id}", "count": 0});
        }
      }

      if (responsee.results?.isNotEmpty ?? false) {
        routeBusData?.forEach((element) {
          for (var element1 in routeBusStopsData) {
            if (element1["stop_id"] == element.stopVehicle?.stopId?.id) {
              element1["count"]++;
            }
          }
        });

        log("routeBusStopsData>>>$routeBusStopsData");
      }
    } else {
      isLoading1 = false;
    }
  }
}
