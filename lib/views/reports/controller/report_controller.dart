import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/Repo/history_repo.dart';
import 'package:wikitrack/Repo/setting_repo.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/response_model/dailt_route_trip_Response_model.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/utils/AppColors.dart';

class ReportController extends GetxController {
  bool isForward = false;

  changeIsForward() {
    isForward = !isForward;
    update();
  }

  TextEditingController searchController = TextEditingController();

  ///get routes
  List<RouteResult> searchDataResults = [];
  List<RouteResult> searchDataResultsAll = [];
  List<RouteResult> tempList = [];
  ApiResponse _getRouteListResponse = ApiResponse.initial(message: 'Initialization');
  ApiResponse get getRouteListResponse => _getRouteListResponse;

  String selRouteId = "";
  String selectedRouteId = "";
  Future getRouteListViewModel() async {
    searchDataResults = [];
    tempList = [];
    update();
    _getRouteListResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetRouteListResModel response = await SettingRepo().getRouteList('${ApiRouts.routeList}');
      // searchDataResults.addAll(response.results!);
      // tempList.addAll(response.results!);

      response.results!.forEach((element) {
        // searchDataResults.add(element);
        bool hasThreeID = searchDataResults.any((mapTested) => mapTested.routeNo == element.routeNo);
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

  searchResult(String value) {
    if (value.isEmpty) {
      searchDataResults = tempList;
    } else {
      searchDataResults = [];
      for (var element in tempList) {
        if (element.name.toString().toLowerCase().contains(value.toString().toLowerCase())) {
          searchDataResults.add(element);
        }
      }
    }
    update();
  }

  setRouteId(String value, String id) {
    selectedRouteId = value;
    selRouteId = id;
    update();
  }

  DateTime toDate = DateTime.now();
  TextEditingController toDateController = TextEditingController();

  toSelectDate(context) async {
    toDate = DateTime.now();

    if (selectedRouteId != "") {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: toDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(3030),
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
        toDateController.clear();
        toDate = picked;
        toDateController.text = toDate.toString().split(" 00").first;
        update();
        log('selectedDate==========>>>>>${toDate}');
        if (selectedRouteId != "") {
          getRoutesSchedules();
        } else {
          commonSnackBar(message: "Please select route");
        }
      }
      update();
    } else {
      commonSnackBar(message: "Please select route");
    }
  }

  int stopIndex = 0;
  int selectedSlot = 0;
  List<TimeSlot> timeSlot = [];
  List<Map<String, dynamic>> stopsTimeData = [];
  getRoutesSchedules({bool isDialog = false}) async {
    timeSlot.clear();
    stopsTimeData.clear();
    stopIndex = 0;
    selectedSlot = 0;
    try {
      DailyRouteTripResponseModel dailyRouteTripResponseModel = await HistoryRepo().dailyTripManagementRepo(
        url:
            "${ApiRouts.dailyRouteTripList}?route_no=${selectedRouteId}&direction=${isForward == true ? '0' : '1'}&date=${toDateController.text}",
      );

      if (dailyRouteTripResponseModel.results!.isEmpty) {
        commonSnackBar(message: "No routes found");
        if (isDialog == true) {
          Get.back();
        }
      } else {
        if (dailyRouteTripResponseModel.results![0].daySlot!.isEmpty) {
          commonSnackBar(message: "No routes found");
          if (isDialog == true) {
            Get.back();
          }
        } else {
          if (dailyRouteTripResponseModel.results![0].daySlot![0].timeSlot!.isNotEmpty) {
            timeSlot.addAll(dailyRouteTripResponseModel.results![0].daySlot![0].timeSlot!);
            update();
            showStopsData(0);
          } else {
            if (isDialog == true) {
              Get.back();
            }
          }
          log("timeSlot--------------> ${timeSlot}");
          log("stopsTimeData--------------> ${stopsTimeData}");
        }
      }
      update();
    } catch (e) {
      log("e--------------> ${e}");
    }
  }

  showStopsData(int index) {
    stopIndex = 0;
    String estimatedTime = "";
    stopsTimeData.clear();
    if (timeSlot[index].dailyrouteTimeslot!.isNotEmpty) {
      DateTime date = timeSlot[0].dailyrouteTimeslot![0].date!;
      if (timeSlot[index].dailyrouteTimeslot![0].actualTime!.isNotEmpty) {
        timeSlot[index].dailyrouteTimeslot![0].actualTime!.forEach((element) {
          if (stopIndex == 0) {
            String time = timeSlot[index].time!;
            String actualTime = element.time!;
            if (element.time == "00") {
              estimatedTime = "${date.add(Duration(minutes: int.parse(element.time!)))}";
            } else {
              estimatedTime =
                  "${date.add(Duration(hours: int.parse(time.split(":")[0]), minutes: int.parse(time.split(":")[1]), seconds: int.parse(time.split(":")[2])))}";
            }
            log("estimatedTime--------------> ${estimatedTime}");
            DateTime actualFinalTime = DateTime.parse('${date}').add(Duration(
                hours: int.parse(actualTime.split(":")[0]),
                minutes: int.parse(actualTime.split(":")[1]),
                seconds: int.parse(actualTime.split(":")[2])));

            log("actualFinalTime--------------> ${actualFinalTime}");

            stopsTimeData.add({
              "stopName": element.stopSeq!.stopId!.name!,
              "estimetedTime": estimatedTime,
              "actualTime": actualFinalTime
            });
          } else {
            String actualTime = element.time!;
            String time = element.stopSeq!.travalTime!;
            log("actualTime--------------> ${actualTime}");
            log("time--------------> ${time}");
            log("estimatedTime--------------> ${estimatedTime}");

            estimatedTime = "${DateTime.parse(estimatedTime).add(Duration(minutes: int.parse(time)))}";
            log("estimatedTime-----dsede---------> ${estimatedTime}");
            DateTime actualFinalTime = date.add(Duration(
                hours: int.parse(actualTime.split(":")[0]),
                minutes: int.parse(actualTime.split(":")[1]),
                seconds: int.parse(actualTime.split(":")[2])));
            log("actualFinalTime-------d-------> ${actualFinalTime}");
            stopsTimeData.add({
              "stopName": element.stopSeq!.stopId!.name!,
              "estimetedTime": estimatedTime,
              "actualTime": actualFinalTime
            });
          }
          stopIndex++;
        });
        update();
      } else {
        commonSnackBar(message: "No actual time found ");
      }
    } else {
      commonSnackBar(message: "No routes found");
    }
    update();
  }
}
