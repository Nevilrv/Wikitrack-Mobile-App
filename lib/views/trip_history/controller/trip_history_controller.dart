import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/response_model/dailt_route_trip_Response_model.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart'
    as vehicle;

import 'package:wikitrack/utils/app_colors.dart';
import 'package:wikitrack/utils/app_images.dart';
import 'package:wikitrack/utils/app_strings.dart';
import 'dart:ui' as ui;
import '../../../Repo/history_repo.dart';
import '../../../Services/base_service.dart';

import '../../../response_model/get_route_list_res_model.dart';

class TripHistoryController extends GetxController {
  var lat;
  var long;
  bool isForward = true;
  bool isForward1 = false;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  changeIsForward(bool value) {
    isForward = value;
    log('isForward==========>>>>>${isForward}');
    String firstText = isForward ? AppStrings.byRoute : AppStrings.byVehicle;
    update();
  }

  DateTime fromDate = DateTime.now();
  selectDate(context, StateSetter setter) async {
    selectedDateIndex = 0;
    vehicleTimeSlotList.clear();
    timeSlotList.clear();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(2021),
      lastDate: toDateController.text == "" ? DateTime(2030) : toDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: AppColors.primaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    update();
    if (picked != null && picked != fromDate) {
      fromDate = picked;
      fromDateController.text = fromDate.toString().split(" 00").first;
      update();
      log("fromDateController.text--------------> ${fromDateController.text}");
      log("toDateController.text--------------> ${toDateController.text}");

      if (fromDateController.text.isNotEmpty &&
          toDateController.text.isNotEmpty) {
        getDaysInBetween(fromDate, toDate);
        if (date != "") {
          if (isForward == true) {
            getVehicles(setter);
          } else {
            getRoutesList(setter);
          }
        }
      }
      log('selectedDate==========>>>>>${fromDate}');
    }
    update();
  }

  DateTime toDate = DateTime.now();
  toSelectDate(context, StateSetter setter) async {
    selectedDateIndex = 0;
    vehicleTimeSlotList.clear();
    timeSlotList.clear();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDateController.text == "" ? toDate : fromDate,
      firstDate: fromDateController.text == "" ? DateTime(2021) : fromDate,
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: AppColors.primaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    update();
    if (picked != null && picked != toDate) {
      toDate = picked;
      toDateController.text = toDate.toString().split(" 00").first;
      update();
      log('selectedDate==========>>>>>${toDate}');

      if (toDateController.text.isNotEmpty &&
          fromDateController.text.isNotEmpty) {
        getDaysInBetween(fromDate, toDate);
        if (date != "") {
          if (isForward == true) {
            getVehicles(setter);
          } else {
            getRoutesList(setter);
          }
        }
      }
    }

    update();
  }

  List<DateTime> days = [];

  String date = "";
  int selectedDateIndex = 0;

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    days.clear();
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    if (days.isNotEmpty) {
      date = days[0].toString().split(' ')[0];
    }
    log("days--------------> ${days}");

    return days;
  }

  changeIsForward1(bool value) {
    isForward1 = value;
    update();
  }

  int indexCheck = 0;

  GetRouteListResModel? getRouteListResModel;
  vehicle.GetVehiclesListResModel? getVehiclesListResModel;

  List<RouteResult> routes = [];
  List<vehicle.Result> vehicles = [];
  RouteResult? dropdownValue;
  Future<void> getAllRoutes() async {
    routes.clear();
    try {
      getRouteListResModel = await HistoryRepo().getRouteList();
      getRouteListResModel!.results!.forEach((element) {
        // searchDataResults.add(element);
        bool hasThreeID =
            routes.any((mapTested) => mapTested.routeNo == element.routeNo);
        if (hasThreeID == true) {
        } else {
          routes.add(element);
          // bool hasThreeID = searchDataResults.any((mapTested) => mapTested.routeNo == element.routeNo);
        }
        log("element.routeNo--------------> ${element.routeNo}  ${hasThreeID}");
      });
      update();
      log("routes--------------> ${routes}");
    } catch (e) {
      log("e--------------> ${e}");
    }
  }

  vehicle.Result? selectedVehicle;
  Future<void> getAllVehicles() async {
    routes.clear();
    try {
      getVehiclesListResModel = await HistoryRepo().getVehicleList();
      vehicles.addAll(getVehiclesListResModel!.results!);
      update();
      log("routes--------------> ${routes}");
    } catch (e) {
      log("e--------------> ${e}");
    }
  }

  List<TimeSlot> timeSlotList = [];
  bool isLoading = false;
  getVehicles(StateSetter setter) async {
    isLoading = true;
    update();
    setter(() {});
    timeSlotList.clear();
    try {
      DailyRouteTripResponseModel dailyRouteTripResponseModel =
          await HistoryRepo().dailyTripManagementRepo(
        url:
            "${ApiRouts.dailyRouteTripList}?route_no=${dropdownValue!.routeNo!}&direction=${isForward1 == true ? '0' : '1'}&date=$date",
      );
      if (dailyRouteTripResponseModel.results!.isNotEmpty) {
        dailyRouteTripResponseModel.results!.forEach((element1) {
          if (element1.daySlot!.isNotEmpty) {
            element1.daySlot!.forEach((element2) {
              if (element2.timeSlot!.isNotEmpty) {
                element2.timeSlot!.forEach((element3) {
                  if (element3.dailyrouteTimeslot![0].vehicle != null) {
                    timeSlotList.add(element3);
                  }
                });
              } else {
                isLoading = false;
                update();
                setter(() {});
              }
            });
          } else {
            isLoading = false;
            update();
            setter(() {});
          }
        });
      } else {
        isLoading = false;
        update();
        setter(() {});
      }
      isLoading = false;
      update();
      setter(() {});
    } catch (e) {
      isLoading = false;
      update();
      setter(() {});
    }
  }

  List<vehicle.Timeslot> vehicleTimeSlotList = [];
  getRoutesList(StateSetter setter) async {
    isLoading = true;
    update();
    vehicleTimeSlotList.clear();
    setter(() {});

    try {
      vehicle.GetVehiclesListResModel getVehiclesListResModel =
          await HistoryRepo().getVehicleRouteTrip(
              url:
                  "${ApiRouts.vehicleRouteTrip}${selectedVehicle!.regNo}&date=$date");
      if (getVehiclesListResModel.results!.isNotEmpty) {
        getVehiclesListResModel.results!.forEach((element) {
          if (element.dailyrouteVehicle!.isNotEmpty) {
            element.dailyrouteVehicle!.forEach((element1) {
              vehicleTimeSlotList.add(element1.timeslot!);
            });
          } else {
            isLoading = false;
            update();
            setter(() {});
          }
        });
      } else {
        isLoading = false;
        update();
        setter(() {});
      }

      log("vehicleTimeSlotList--------------> ${vehicleTimeSlotList}");

      // if (dailyRouteTripResponseModel.results!.isNotEmpty) {
      //   dailyRouteTripResponseModel.results!.forEach((element) {
      //     if (element.daySlot!.isNotEmpty) {
      //       element.daySlot!.forEach((element) {
      //         if (element.timeSlot!.isNotEmpty) {
      //           timeSlotList.addAll(element.timeSlot!);
      //         } else {
      //           isLoading = false;
      //           update();
      //           setter(() {});
      //         }
      //       });
      //     } else {
      //       isLoading = false;
      //       update();
      //       setter(() {});
      //     }
      //   });
      // } else {
      //   isLoading = false;
      //   update();
      //   setter(() {});
      // }
      isLoading = false;
      update();
      setter(() {});
    } catch (e) {
      isLoading = false;
      update();
      setter(() {});
    }
  }

  List<Marker> markers = <Marker>[];
  Completer<GoogleMapController> googleMapController = Completer();
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  int stopIndex = 0;
  List<vehicle.Result> results = [];
  getVehiclesOneRoute(String time) async {
    results.clear();
    stopIndex = 0;
    update();
    vehicle.GetVehiclesListResModel getVehiclesListResModel =
        await HistoryRepo().getVehicleRouteTrip(
            url:
                "${ApiRouts.vehicleRouteTrip}${selectedVehicle!.regNo}&date=$date&time=$time");

    if (getVehiclesListResModel.results!.isNotEmpty) {
      results.addAll(getVehiclesListResModel.results!);
      update();
    } else {
      commonSnackBar("No routes found");
    }
  }

  List<DailyTripManagementResult> routesVehicleResult = [];
  getRoutesOnVehicle(String time, StateSetter stateSetter) async {
    routesVehicleResult.clear();
    stopIndex = 0;
    update();
    DailyRouteTripResponseModel dailyRouteTripResponseModel =
        await HistoryRepo().dailyTripManagementRepo(
      url:
          "${ApiRouts.dailyRouteTripList}?route_no=${dropdownValue!.routeNo!}&direction=${isForward1 == true ? '0' : '1'}&date=$date&time=$time",
    );
    if (dailyRouteTripResponseModel.results!.isNotEmpty) {
      routesVehicleResult.addAll(dailyRouteTripResponseModel.results!);
    } else {
      isLoading1 = false;
      stateSetter(() {});
      commonSnackBar("No routes found");
    }
    isLoading1 = false;
    stateSetter(() {});
    update();
  }

  bool isLoading1 = false;

  addMarkersRoutes(StateSetter stateSetter) async {
    final Uint8List stopsIcons = await getImages(AppImages.busStopMap, 100);
    markers.clear();
    isLoading1 = true;
    polylineCoordinates.clear();
    polylines.clear();
    stateSetter(() {});
    log("results--------------> ${routesVehicleResult}");

    if (routesVehicleResult.isEmpty) {
      Get.back();
      isLoading1 = false;
      stateSetter(() {});
      commonSnackBar("No routes found");
    } else {
      log("results---------vfd-----> ${results}");

      if (routesVehicleResult[0].daySlot!.isEmpty) {
        commonSnackBar("No routes found");
      } else {
        if (routesVehicleResult[0].daySlot![0].timeSlot!.isEmpty) {
          commonSnackBar("No routes found");
        } else {
          routesVehicleResult[0].daySlot![0].timeSlot!.forEach((element2) {
            if (element2.dailyrouteTimeslot!.isEmpty) {
              commonSnackBar("No routes found");
            } else {
              element2.dailyrouteTimeslot!.forEach((element1) async {
                String flat = '';
                String flang = '';
                String estimatedTime = '';
                if (element1.vehicle == null) {
                } else {
                  if (element1.actualTime!.isNotEmpty) {
                    log('empty---------ed-');

                    element1.actualTime!.forEach((element2) async {
                      List data =
                          element2.stopSeq!.stopId!.location!.split(',');
                      String lat;
                      String lang;
                      if (data.length == 2) {
                        lat = data[0];
                        lang = data[1];
                      } else {
                        lat = data[0];
                        lang = data[2];
                      }
                      if (stopIndex == 0) {
                        String time = routesVehicleResult[0]
                            .daySlot![0]
                            .timeSlot![0]
                            .time!;
                        String actualTime = element2.time!;
                        if (element2.time == "00") {
                          estimatedTime =
                              "${DateTime.parse('${element1.date}').add(Duration(minutes: int.parse(element2.time!)))}";
                        } else {
                          estimatedTime =
                              "${DateTime.parse('${element1.date}').add(Duration(hours: int.parse(time.split(":")[0]), minutes: int.parse(time.split(":")[1]), seconds: int.parse(time.split(":")[2])))}";
                        }
                        log("estimatedTime--------------> ${estimatedTime}");
                        DateTime actualFinalTime =
                            DateTime.parse('${element1.date}').add(Duration(
                                hours: int.parse(actualTime.split(":")[0]),
                                minutes: int.parse(actualTime.split(":")[1]),
                                seconds: int.parse(actualTime.split(":")[2])));

                        log("actualFinalTime--------------> ${actualFinalTime}");

                        flat = lat;
                        flang = lang;
                        markers.add(Marker(
                          // given marker id
                          markerId: MarkerId("Stop ${stopIndex.toString()}"),
                          // given marker icon
                          icon: BitmapDescriptor.fromBytes(stopsIcons),
                          // given position
                          position:
                              LatLng(double.parse(lat), double.parse(lang)),
                          infoWindow: InfoWindow(
                              // given title for marker
                              title: 'Stop: ' +
                                  element2.stopSeq!.stopId!.name.toString(),
                              snippet:
                                  "ActualTime:${DateFormat('hh:mm a').format(DateTime.parse(estimatedTime))} EstimatedTime:${DateFormat('hh:mm a').format(actualFinalTime)}"),
                        ));
                      } else {
                        String actualTime = element2.time!;
                        String time = element2.stopSeq!.travalTime!;
                        estimatedTime =
                            "${DateTime.parse(estimatedTime).add(Duration(minutes: int.parse(time)))}";
                        log("estimatedTime-----dsede---------> ${estimatedTime}");
                        DateTime actualFinalTime =
                            DateTime.parse('${element1.date}').add(Duration(
                                hours: int.parse(actualTime.split(":")[0]),
                                minutes: int.parse(actualTime.split(":")[1]),
                                seconds: int.parse(actualTime.split(":")[2])));
                        log("actualFinalTime-------d-------> ${actualFinalTime}");

                        markers.add(Marker(
                          // given marker id
                          markerId: MarkerId("Stop ${stopIndex.toString()}"),
                          // given marker icon
                          icon: BitmapDescriptor.fromBytes(stopsIcons),
                          // given position
                          position:
                              LatLng(double.parse(lat), double.parse(lang)),
                          infoWindow: InfoWindow(
                              // given title for marker
                              title: 'Stop: ' +
                                  element2.stopSeq!.stopId!.name.toString(),
                              snippet:
                                  "ActualTime:${DateFormat('hh:mm a').format(actualFinalTime)} EstimatedTime:${DateFormat('hh:mm a').format(DateTime.parse(estimatedTime))}"),
                        ));
                      }

                      stopIndex++;
                    });

                    GoogleMapController controller =
                        await googleMapController.future;
                    controller.animateCamera(CameraUpdate.newCameraPosition(
                        // on below line we have given positions of Location 5
                        CameraPosition(
                      target: LatLng(double.parse(flat), double.parse(flang)),
                      zoom: 15,
                    )));
                    update();
                    stateSetter(() {});
                  } else {
                    Get.back();
                    isLoading1 = false;
                    stateSetter(() {});
                    // stateSetter(() {});
                    commonSnackBar("No actual time found");
                    // Get.snackbar("Wikitrack", "No actual time found",
                    //     backgroundColor: AppColors.primaryColor,
                    //     colorText: AppColors.whiteColor,
                    //     snackPosition: SnackPosition.BOTTOM);
                  }
                }
              });
              element2.dailyrouteTimeslot!.forEach((element1) async {
                if (element1.vehicle == null) {
                } else {
                  polylineCoordinates.clear();
                  // polylines.clear();
                  int changeIndex = 0;

                  if (element1.actualTime!.isEmpty) {
                    // commonSnackBar( "No actual time found");
                    // Get.back();
                    // stateSetter(() {});
                  } else {
                    for (int i = 0; i < element1.actualTime!.length; i++) {
                      if (changeIndex == 0) {
                        changeIndex++;
                      } else {
                        log("changeIndex-------------->${changeIndex - 1} -- ${changeIndex}");

                        List data = element1.actualTime![changeIndex - 1]
                            .stopSeq!.stopId!.location!
                            .split(',');
                        List data1 = element1
                            .actualTime![changeIndex].stopSeq!.stopId!.location!
                            .split(',');
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
                            polylineCoordinates
                                .add(LatLng(point.latitude, point.longitude));
                            log("point.latitude--------------> ${point.latitude}");
                            log("point.longitude--------------> ${point.longitude}");
                          }
                        }
                        _addPolyLine(i);

                        changeIndex++;
                        update();
                      }

                      log("changeIndex--------------> ${changeIndex}");

                      //

                      update();
                    }
                    isLoading1 = false;
                    stateSetter(() {});
                    Get.back();
                  }
                }
              });
            }
          });
        }
      }
    }
    log("markers--------------> ${markers}");

    update();
    isLoading1 = false;
    stateSetter(() {});
  }

  addMarkers(StateSetter stateSetter) async {
    final Uint8List stopsIcons = await getImages(AppImages.busStopMap, 100);
    markers.clear();
    isLoading1 = true;
    polylineCoordinates.clear();
    polylines.clear();
    stateSetter(() {});
    log("results--------------> ${results}");

    if (results.isEmpty) {
      Get.back();
      isLoading1 = false;
      stateSetter(() {});
      commonSnackBar("No routes found");
    } else {
      log("results---------vfd-----> ${results}");
      if (results[0].dailyrouteVehicle!.isNotEmpty) {
        // results.forEach((element) {
        //   element.dailyrouteVehicle
        //
        // });
        results[0].dailyrouteVehicle!.forEach((element1) async {
          String flat = '';
          String flang = '';
          String estimatedTime = '';
          if (element1.actualTime!.isNotEmpty) {
            log('empty---------ed-');

            element1.actualTime!.forEach((element2) async {
              List data = element2.stopSeq!.stopId!.location!.split(',');
              String lat;
              String lang;
              if (data.length == 2) {
                lat = data[0];
                lang = data[1];
              } else {
                lat = data[0];
                lang = data[2];
              }
              if (stopIndex == 0) {
                String time = element1.timeslot!.time!;
                String actualTime = element2.time!;
                if (element2.time == "00") {
                  estimatedTime =
                      "${DateTime.parse('${element1.date}').add(Duration(minutes: int.parse(element2.time!)))}";
                } else {
                  estimatedTime =
                      "${DateTime.parse('${element1.date}').add(Duration(hours: int.parse(time.split(":")[0]), minutes: int.parse(time.split(":")[1]), seconds: int.parse(time.split(":")[2])))}";
                }
                log("estimatedTime--------------> ${estimatedTime}");
                DateTime actualFinalTime = DateTime.parse('${element1.date}')
                    .add(Duration(
                        hours: int.parse(actualTime.split(":")[0]),
                        minutes: int.parse(actualTime.split(":")[1]),
                        seconds: int.parse(actualTime.split(":")[2])));

                log("actualFinalTime--------------> ${actualFinalTime}");

                flat = lat;
                flang = lang;
                markers.add(Marker(
                  // given marker id
                  markerId: MarkerId("Stop ${stopIndex.toString()}"),
                  // given marker icon
                  icon: BitmapDescriptor.fromBytes(stopsIcons),
                  // given position
                  position: LatLng(double.parse(lat), double.parse(lang)),
                  infoWindow: InfoWindow(
                      // given title for marker
                      title:
                          'Stop: ' + element2.stopSeq!.stopId!.name.toString(),
                      snippet:
                          "ActualTime:${DateFormat('hh:mm a').format(DateTime.parse(estimatedTime))} EstimatedTime:${DateFormat('hh:mm a').format(actualFinalTime)}"),
                ));
              } else {
                String actualTime = element2.time!;
                String time = element2.stopSeq!.travalTime!;
                estimatedTime =
                    "${DateTime.parse(estimatedTime).add(Duration(minutes: int.parse(time)))}";
                log("estimatedTime-----dsede---------> ${estimatedTime}");
                DateTime actualFinalTime = DateTime.parse('${element1.date}')
                    .add(Duration(
                        hours: int.parse(actualTime.split(":")[0]),
                        minutes: int.parse(actualTime.split(":")[1]),
                        seconds: int.parse(actualTime.split(":")[2])));
                log("actualFinalTime-------d-------> ${actualFinalTime}");

                markers.add(Marker(
                  // given marker id
                  markerId: MarkerId("Stop ${stopIndex.toString()}"),
                  // given marker icon
                  icon: BitmapDescriptor.fromBytes(stopsIcons),
                  // given position
                  position: LatLng(double.parse(lat), double.parse(lang)),
                  infoWindow: InfoWindow(
                      // given title for marker
                      title:
                          'Stop: ' + element2.stopSeq!.stopId!.name.toString(),
                      snippet:
                          "ActualTime:${DateFormat('hh:mm a').format(actualFinalTime)} EstimatedTime:${DateFormat('hh:mm a').format(DateTime.parse(estimatedTime))}"),
                ));
              }

              stopIndex++;
            });

            GoogleMapController controller = await googleMapController.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                // on below line we have given positions of Location 5
                CameraPosition(
              target: LatLng(double.parse(flat), double.parse(flang)),
              zoom: 15,
            )));
            update();
          } else {
            log('empty----------');

            Get.back();
            isLoading1 = false;
            stateSetter(() {});
            commonSnackBar("No actual time found");
          }
        });
        results[0].dailyrouteVehicle!.forEach((element) async {
          polylineCoordinates.clear();
          polylines.clear();
          int changeIndex = 0;
          if (element.actualTime!.isEmpty) {
          } else {
            for (int i = 0; i < element.actualTime!.length; i++) {
              if (changeIndex == 0) {
                changeIndex++;
              } else {
                log("changeIndex-------------->${changeIndex - 1} -- ${changeIndex}");

                List data = element
                    .actualTime![changeIndex - 1].stopSeq!.stopId!.location!
                    .split(',');
                List data1 = element
                    .actualTime![changeIndex].stopSeq!.stopId!.location!
                    .split(',');
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
                    polylineCoordinates
                        .add(LatLng(point.latitude, point.longitude));
                    log("point.latitude--------------> ${point.latitude}");
                    log("point.longitude--------------> ${point.longitude}");
                  }
                }
                _addPolyLine(i);

                changeIndex++;
                update();
              }

              log("changeIndex--------------> ${changeIndex}");

              //

              update();
            }
            isLoading1 = false;
            stateSetter(() {});
            Get.back();
          }
        });
      } else {
        isLoading1 = false;
        stateSetter(() {});
        commonSnackBar("No routes found");
      }
    }

    update();
    stateSetter(() {});
  }

  _addPolyLine(int i) {
    PolylineId id = PolylineId("poly $i");
    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.primaryColor,
        points: polylineCoordinates,
        width: 3);
    polylines[id] = polyline;
    update();
  }
}
