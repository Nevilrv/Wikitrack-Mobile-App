import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/views/settings/controller/setting_controller.dart';

class AppDialog {
  selectRouteDialog(
    context, {
    String? title,
    bool isTrip = false,
    String? from,
    required SettingController controller,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState123) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: const EdgeInsets.only(top: 10.0),
              title: Text(
                title.toString(),
                style: const TextStyle(fontSize: 24.0),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        commonTextField(
                          onChanged: (p0) {
                            controller.searchResult(p0);
                            setState123(() {});
                          },
                          controller: controller.searchController,
                          textColor: AppColors.blackColor,
                          color: AppColors.iconGreyColor,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.searchDataResults.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.setRouteId(controller.searchDataResults[index].id.toString());

                                  Get.back();
                                  setState123(() {});
                                  controller.update();
                                },
                                child: from == "bus_time_table"
                                    ? Column(
                                        children: [
                                          SizedBox(height: 15),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Text(
                                              (controller.searchDataResults[index].routeNo.toString().isEmpty
                                                      ? "NA"
                                                      : controller.searchDataResults[index].routeNo)
                                                  .toString(),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Divider(height: 3)
                                        ],
                                      )
                                    : from == "daily_trip_management"
                                        ? Column(
                                            children: [
                                              SizedBox(height: 15),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                child: Text(
                                                  (controller.searchDataResults[index].name.toString().isEmpty
                                                          ? "NA"
                                                          : controller.searchDataResults[index].name)
                                                      .toString()
                                                      .capitalizeFirst
                                                      .toString(),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Divider(height: 3)
                                            ],
                                          )
                                        : controller.searchDataResults[index].direction == "1"
                                            ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 15),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: Text(
                                                      (controller.searchDataResults[index].name.toString().isEmpty
                                                              ? "NA"
                                                              : controller.searchDataResults[index].name)
                                                          .toString()
                                                          .capitalizeFirst
                                                          .toString(),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Divider(height: 3)
                                                ],
                                              )
                                            : SizedBox(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then(
      (value) async {
        if (controller.selectedDate != null && isTrip == true) {
          controller.data.clear();
          await controller.dailyTripManagementViewModel(
            routeId: controller.searchDataResults
                .where((element) => element.id == controller.selectedRouteId)
                .first
                .routeNo
                .toString()
                .replaceAll(" ", "%20"),
            direction: controller.isForward ? "0" : "1",
            day: DateFormat("EEEE").format(controller.selectedDate!),
          );
        }

        if (isTrip == false && controller.selectedRouteId != null) {
          controller.busTimeTableData.clear();
          await controller.busTimeTableViewModel(
            routeId: controller.searchDataResults
                .where((element) => element.id == controller.selectedRouteId)
                .first
                .routeNo
                .toString()
                .replaceAll(" ", "%20"),
            direction: controller.isForward ? "0" : "1",
          );
        }
        controller.update();
      },
    );
  }

  selectStopDialog(
    context, {
    String? title,
    required SettingController controller,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState123) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: const EdgeInsets.only(top: 10.0),
              title: Text(
                title.toString(),
                style: const TextStyle(fontSize: 24.0),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        commonTextField(
                          onChanged: (p0) {
                            controller.searchStop(p0);
                            setState123(() {});
                          },
                          controller: controller.searchController,
                          textColor: AppColors.blackColor,
                          color: AppColors.iconGreyColor,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(height: 0);
                            },
                            itemCount: controller.stopResult.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Get.back();
                                  controller.stop.text = controller.stopResult[index].name;
                                  controller.stopId = controller.stopResult[index].id;
                                },
                                title: Text(
                                  (controller.stopResult[index].name.isEmpty ? 'NA' : controller.stopResult[index].name)
                                      .toString()
                                      .capitalizeFirst
                                      .toString(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  selectStopDisplayDialog(
    context, {
    String? title,
    required SettingController controller,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState123) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: const EdgeInsets.only(top: 10.0),
              title: Text(
                title.toString(),
                style: const TextStyle(fontSize: 24.0),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        commonTextField(
                          onChanged: (p0) {
                            controller.searchStopDisplayResult(p0);
                            setState123(() {});
                          },
                          controller: controller.searchController,
                          textColor: AppColors.blackColor,
                          color: AppColors.iconGreyColor,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(height: 0);
                            },
                            itemCount: controller.stopDisplayResult.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Get.back();
                                  controller.stopDevice.text = controller.stopDisplayResult[index].imei;
                                  controller.stopDisplayId = controller.stopDisplayResult[index].id;
                                },
                                title: Text(
                                  (controller.stopDisplayResult[index].imei.isEmpty
                                          ? "NA"
                                          : controller.stopDisplayResult[index].imei)
                                      .toString()
                                      .capitalizeFirst
                                      .toString(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
