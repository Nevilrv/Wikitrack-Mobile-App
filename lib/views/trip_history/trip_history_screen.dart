import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/trip_history/controller/trip_history_controller.dart';
import 'package:wikitrack/response_model/get_vehicle_list_res_model.dart'
    as vehicle;

import '../../response_model/daily_trip_route_res_model.dart';
import '../../response_model/get_route_list_res_model.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  TripHistoryController tripHistoryController = Get.find();
  Position? currentPosition;
  List<Result> list = [];
  bool isLoading = false;
  int count = -1;
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentPosition();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tripHistoryController.getAllRoutes();
      tripHistoryController.getAllVehicles();
    });
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    setState(() {
      isLoading = true;
    });
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() => currentPosition = position);
        log('currentPosition!.latitude==========>>>>>${currentPosition!.latitude}');
        log('currentPosition!.longitude==========>>>>>${currentPosition!.longitude}');
        tripHistoryController.lat = currentPosition!.latitude;
        tripHistoryController.long = currentPosition!.longitude;
      }).catchError((e) {
        debugPrint("ERROR=========$e");
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: commonSubTitleAppBar(
          title: AppStrings.tripHistory,
          subTitle: AppStrings.bmtc,
          onTap: () {
            Get.back();
          },
          actions: [
            GetBuilder<TripHistoryController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                      onTap: () {
                        controller.date = "";
                        controller.selectedDateIndex = 0;
                        count = -1;
                        controller.isForward1 = false;
                        controller.isForward = true;
                        controller.dropdownValue = null;
                        controller.selectedVehicle = null;
                        controller.toDateController.clear();
                        controller.toDate = DateTime.now();
                        controller.fromDateController.clear();
                        controller.selectedDateIndex = 0;
                        controller.fromDateController.clear();
                        controller.timeSlotList.clear();
                        controller.results.clear();
                        controller.routesVehicleResult.clear();
                        controller.isLoading1 = false;
                        controller.fromDate = DateTime.now();
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Container(
                                height: h * 0.75,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.03),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: h * 0.015,
                                      ),
                                      Text(
                                        "${AppStrings.tripHistory} Filters",
                                        style: blackMedium16TextStyle.copyWith(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            controller.isForward == true
                                                ? AppStrings.byRoute
                                                : AppStrings.byVehicle,
                                            style:
                                                blackMedium14TextStyle.copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
                                          SizedBox(
                                            height: h * 0.04,
                                            width: w * 0.13,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: CupertinoSwitch(
                                                activeColor:
                                                    AppColors.iconBlueColor,
                                                thumbColor:
                                                    AppColors.whiteColor,
                                                trackColor:
                                                    AppColors.iconBlueColor,
                                                value: controller.isForward,
                                                onChanged: (val) async {
                                                  log("nvjsdnvbjsnvbksd");
                                                  controller
                                                      .changeIsForward(val);
                                                  controller.date = "";
                                                  controller.selectedDateIndex =
                                                      0;
                                                  count = -1;
                                                  controller.dropdownValue =
                                                      null;
                                                  controller.selectedVehicle =
                                                      null;
                                                  controller.toDateController
                                                      .clear();
                                                  controller.toDate =
                                                      DateTime.now();
                                                  controller.selectedDateIndex =
                                                      0;
                                                  controller.fromDateController
                                                      .clear();
                                                  controller.timeSlotList
                                                      .clear();
                                                  controller.vehicleTimeSlotList
                                                      .clear();
                                                  controller.results.clear();
                                                  controller.routesVehicleResult
                                                      .clear();
                                                  controller.isLoading1 = false;
                                                  controller.fromDate =
                                                      DateTime.now();
                                                  controller.isForward1 = false;

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      controller.isForward == true
                                          ? Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: w * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .lightGreyColor),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      w * 0.02),
                                                          child: DropdownButton<
                                                              RouteResult>(
                                                            value: controller
                                                                .dropdownValue,
                                                            isExpanded: true,
                                                            icon: const Icon(
                                                                CupertinoIcons
                                                                    .chevron_down),
                                                            hint: Text(
                                                                AppStrings
                                                                    .route),
                                                            elevation: 16,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .deepPurple),
                                                            underline:
                                                                SizedBox(),
                                                            onChanged:
                                                                (RouteResult?
                                                                    value) {
                                                              // This is called when the user selects an item.

                                                              count = -1;
                                                              setState(() {
                                                                controller
                                                                        .dropdownValue =
                                                                    value;
                                                              });
                                                              controller
                                                                  .selectedDateIndex = 0;
                                                              controller
                                                                  .vehicleTimeSlotList
                                                                  .clear();
                                                              controller
                                                                  .timeSlotList
                                                                  .clear();
                                                              if (controller
                                                                      .date !=
                                                                  "") {
                                                                controller
                                                                    .getVehicles(
                                                                        setState);
                                                              }
                                                            },
                                                            items: controller
                                                                .routes
                                                                .map(
                                                                    (RouteResult
                                                                        value) {
                                                              return DropdownMenuItem<
                                                                  RouteResult>(
                                                                value: value,
                                                                child: Text(value
                                                                    .routeNo!),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                        height: h * 0.04,
                                                        width: w * 0.13,
                                                        child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          child:
                                                              CupertinoSwitch(
                                                            activeColor: AppColors
                                                                .iconBlueColor,
                                                            thumbColor:
                                                                AppColors
                                                                    .whiteColor,
                                                            trackColor: AppColors
                                                                .iconBlueColor,
                                                            value: controller
                                                                .isForward1,
                                                            onChanged:
                                                                (val) async {
                                                              count = -1;

                                                              if (controller
                                                                      .dropdownValue ==
                                                                  null) {
                                                                commonSnackBar(
                                                                    message:
                                                                        "Please select route");
                                                              } else if (controller
                                                                  .fromDateController
                                                                  .text
                                                                  .isEmpty) {
                                                                commonSnackBar(
                                                                    message:
                                                                        "Please select from date");
                                                              } else if (controller
                                                                  .toDateController
                                                                  .text
                                                                  .isEmpty) {
                                                                commonSnackBar(
                                                                    message:
                                                                        "Please select to date");
                                                              } else {
                                                                controller
                                                                    .changeIsForward1(
                                                                        val);
                                                                controller
                                                                    .getVehicles(
                                                                        setState);
                                                              }

                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "To/From",
                                                        style: blackMedium14TextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.02,
                                                  ),
                                                  /* controller.dropdownValue == null
                                                                  ? SizedBox()
                                                                  : */
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                  height:
                                                                      h * 0.06,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .lightGreyColor),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          TextFormField(
                                                                        onTap:
                                                                            () async {
                                                                          if (controller.dropdownValue ==
                                                                              null) {
                                                                            commonSnackBar(message: "Please select route");
                                                                          } else {
                                                                            count =
                                                                                -1;
                                                                            await controller.selectDate(context,
                                                                                setState);
                                                                            controller.update();
                                                                            setState(() {});
                                                                          }
                                                                        },
                                                                        readOnly:
                                                                            true,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              "From Date",
                                                                          hintStyle:
                                                                              greyMedium14TextStyle.copyWith(color: AppColors.mediumGreyColor),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                        keyboardType:
                                                                            TextInputType.none,
                                                                        controller:
                                                                            controller.fromDateController,
                                                                        style: greyMedium14TextStyle.copyWith(
                                                                            color:
                                                                                AppColors.mediumGreyColor),
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                            SizedBox(
                                                              width: w * 0.03,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                height:
                                                                    h * 0.06,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .lightGreyColor),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  child:
                                                                      TextFormField(
                                                                    onTap:
                                                                        () async {
                                                                      if (controller
                                                                              .dropdownValue ==
                                                                          null) {
                                                                        commonSnackBar(
                                                                            message:
                                                                                "Please select route");
                                                                      } else {
                                                                        count =
                                                                            -1;
                                                                        await controller.toSelectDate(
                                                                            context,
                                                                            setState);
                                                                        controller
                                                                            .update();
                                                                        setState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    readOnly:
                                                                        true,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "To Date",
                                                                        hintStyle: greyMedium14TextStyle.copyWith(
                                                                            color: AppColors
                                                                                .mediumGreyColor),
                                                                        border:
                                                                            InputBorder.none),
                                                                    controller:
                                                                        controller
                                                                            .toDateController,
                                                                    style: greyMedium14TextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.mediumGreyColor),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: h * 0.02,
                                                        ),
                                                        controller.fromDateController
                                                                        .text ==
                                                                    "" ||
                                                                controller
                                                                        .toDateController
                                                                        .text ==
                                                                    ""
                                                            ? SizedBox()
                                                            : controller.days
                                                                    .isEmpty
                                                                ? Text(
                                                                    "No days found")
                                                                : Container(
                                                                    height: h *
                                                                        0.05,
                                                                    width:
                                                                        w * 1,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: controller
                                                                          .days
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: w * 0.01),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              log("controller.days[index]--------------> ${controller.days[index]}");
                                                                              count = -1;
                                                                              controller.selectedDateIndex = index;
                                                                              controller.date = controller.days[index].toString().split(" ").first;
                                                                              controller.getVehicles(setState);

                                                                              controller.update();
                                                                              setState(() {});
                                                                              log("date--------------> ${controller.date}");
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  10,
                                                                                ),
                                                                                border: Border.all(color: controller.selectedDateIndex == index ? AppColors.primaryColor : AppColors.lightGreyColor),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.02),
                                                                                child: Text(
                                                                                  "${DateFormat('dd MMM yyyy').format(controller.days[index])}",
                                                                                  style: greyMedium14TextStyle.copyWith(
                                                                                    color: AppColors.mediumGreyColor,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                        SizedBox(
                                                          height: h * 0.02,
                                                        ),
                                                        controller.isLoading ==
                                                                true
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ))
                                                            : controller
                                                                    .timeSlotList
                                                                    .isEmpty
                                                                ? Center(
                                                                    child: Text(
                                                                        "No vehicle found"))
                                                                : Container(
                                                                    height: h *
                                                                        0.31,
                                                                    width:
                                                                        w * 1,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: controller
                                                                          .timeSlotList
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        log("controller.timeSlotList[index].dailyrouteTimeslot![0].vehicle?.regNo--------------> ${controller.timeSlotList[index].dailyrouteTimeslot![0].vehicle?.regNo}");

                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            count =
                                                                                index;
                                                                            log('count==========>>>>>${count}');
                                                                            log('index==========>>>>>${index}');
                                                                            controller.getRoutesOnVehicle(controller.timeSlotList[index].time!,
                                                                                setState);
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: h * 0.005),
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: count == index ? AppColors.pinkColor : Colors.transparent,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    10,
                                                                                  ),
                                                                                  border: Border.all(color: AppColors.pinkColor),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.011),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        '${index + 1} ${controller.timeSlotList[index].dailyrouteTimeslot![0].vehicle?.regNo!}',
                                                                                        style: greyMedium14TextStyle.copyWith(
                                                                                          color: AppColors.mediumGreyColor,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        "${controller.timeSlotList[index].time}",
                                                                                        style: greyMedium14TextStyle.copyWith(
                                                                                          color: AppColors.mediumGreyColor,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                        Spacer(),
                                                        controller.isLoading1 ==
                                                                true
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ))
                                                            : count == -1
                                                                ? SizedBox()
                                                                : CommonButton(
                                                                    title:
                                                                        "Select",
                                                                    onTap: () {
                                                                      controller
                                                                          .addMarkersRoutes(
                                                                              setState);
                                                                    }),
                                                        SizedBox(
                                                          height: h * 0.02,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: w * 1,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .lightGreyColor),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  w * 0.02),
                                                      child: DropdownButton<
                                                          vehicle.Result>(
                                                        value: controller
                                                            .selectedVehicle,
                                                        isExpanded: true,
                                                        icon: const Icon(
                                                            CupertinoIcons
                                                                .chevron_down),
                                                        hint: Text(
                                                            AppStrings.vehicle),
                                                        elevation: 16,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .deepPurple),
                                                        underline: SizedBox(),
                                                        onChanged:
                                                            (vehicle.Result?
                                                                value) {
                                                          count = -1;
                                                          // This is called when the user selects an item.
                                                          setState(() {
                                                            controller
                                                                    .selectedVehicle =
                                                                value!;
                                                          });
                                                          controller
                                                              .selectedDateIndex = 0;
                                                          controller
                                                              .vehicleTimeSlotList
                                                              .clear();
                                                          controller
                                                              .timeSlotList
                                                              .clear();
                                                          if (controller.date !=
                                                              "") {
                                                            controller
                                                                .getRoutesList(
                                                                    setState);
                                                          }
                                                        },
                                                        items: controller
                                                            .vehicles
                                                            .map((vehicle.Result
                                                                value) {
                                                          return DropdownMenuItem<
                                                              vehicle.Result>(
                                                            value: value,
                                                            child: Text(
                                                                value.regNo!),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: h * 0.02,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                  height:
                                                                      h * 0.06,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .lightGreyColor),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          TextFormField(
                                                                        onTap:
                                                                            () async {
                                                                          if (controller.selectedVehicle ==
                                                                              null) {
                                                                            commonSnackBar(message: "Please select vehicle");
                                                                          } else {
                                                                            count =
                                                                                -1;
                                                                            await controller.selectDate(context,
                                                                                setState);
                                                                            controller.update();
                                                                            setState(() {});
                                                                          }
                                                                        },
                                                                        readOnly:
                                                                            true,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              "From Date",
                                                                          hintStyle:
                                                                              greyMedium14TextStyle.copyWith(color: AppColors.mediumGreyColor),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                        keyboardType:
                                                                            TextInputType.none,
                                                                        controller:
                                                                            controller.fromDateController,
                                                                        style: greyMedium14TextStyle.copyWith(
                                                                            color:
                                                                                AppColors.mediumGreyColor),
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                            SizedBox(
                                                              width: w * 0.03,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                height:
                                                                    h * 0.06,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .lightGreyColor),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  child:
                                                                      TextFormField(
                                                                    onTap:
                                                                        () async {
                                                                      if (controller
                                                                              .selectedVehicle ==
                                                                          null) {
                                                                        commonSnackBar(
                                                                            message:
                                                                                "Please select vehicle");
                                                                      } else {
                                                                        count =
                                                                            -1;
                                                                        await controller.toSelectDate(
                                                                            context,
                                                                            setState);
                                                                        controller
                                                                            .update();
                                                                        setState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    readOnly:
                                                                        true,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "To Date",
                                                                        hintStyle: greyMedium14TextStyle.copyWith(
                                                                            color: AppColors
                                                                                .mediumGreyColor),
                                                                        border:
                                                                            InputBorder.none),
                                                                    controller:
                                                                        controller
                                                                            .toDateController,
                                                                    style: greyMedium14TextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.mediumGreyColor),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: h * 0.02,
                                                        ),
                                                        controller.fromDateController
                                                                        .text ==
                                                                    "" ||
                                                                controller
                                                                        .toDateController
                                                                        .text ==
                                                                    ""
                                                            ? SizedBox()
                                                            : controller.days
                                                                    .isEmpty
                                                                ? Text(
                                                                    "No days found")
                                                                : Container(
                                                                    height: h *
                                                                        0.05,
                                                                    width:
                                                                        w * 1,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: controller
                                                                          .days
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: w * 0.01),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              controller.selectedDateIndex = index;
                                                                              controller.date = controller.days[index].toString().split(" ").first;
                                                                              count = -1;
                                                                              controller.getRoutesList(setState);
                                                                              controller.update();
                                                                              setState(() {});
                                                                              log("date--------------> ${controller.date}");
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  10,
                                                                                ),
                                                                                border: Border.all(color: controller.selectedDateIndex == index ? AppColors.primaryColor : AppColors.lightGreyColor),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.02),
                                                                                child: Text(
                                                                                  "${DateFormat('dd MMM yyyy').format(controller.days[index])}",
                                                                                  style: greyMedium14TextStyle.copyWith(
                                                                                    color: AppColors.mediumGreyColor,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                        SizedBox(
                                                          height: h * 0.02,
                                                        ),
                                                        controller.isLoading ==
                                                                true
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ))
                                                            : controller
                                                                    .vehicleTimeSlotList
                                                                    .isEmpty
                                                                ? Center(
                                                                    child: Text(
                                                                        "No routes found"))
                                                                : Container(
                                                                    height: h *
                                                                        0.31,
                                                                    width:
                                                                        w * 1,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: controller
                                                                          .vehicleTimeSlotList
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            count =
                                                                                index;
                                                                            log('count==========>>>>>${count}');
                                                                            log('index==========>>>>>${index}');
                                                                            controller.getVehiclesOneRoute(controller.vehicleTimeSlotList[index].time!);
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: h * 0.005),
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: count == index ? AppColors.pinkColor : Colors.transparent,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    10,
                                                                                  ),
                                                                                  border: Border.all(color: AppColors.pinkColor),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.011),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        "${index + 1}. (${controller.vehicleTimeSlotList[index].dayslot!.timetable!.route!.name})",
                                                                                        style: greyMedium14TextStyle.copyWith(
                                                                                          color: AppColors.mediumGreyColor,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        "${controller.vehicleTimeSlotList[index].time}",
                                                                                        style: greyMedium14TextStyle.copyWith(
                                                                                          color: AppColors.mediumGreyColor,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                        Spacer(),
                                                        controller.isLoading1 ==
                                                                true
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ))
                                                            : count == -1
                                                                ? SizedBox()
                                                                : CommonButton(
                                                                    title:
                                                                        "Select",
                                                                    onTap: () {
                                                                      controller
                                                                          .addMarkers(
                                                                              setState);
                                                                    }),
                                                        SizedBox(
                                                          height: h * 0.02,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: SvgPicture.asset(AppImages.menuIcon)),
                );
              },
            )
          ]),
      body: GetBuilder<TripHistoryController>(builder: (controller) {
        return Container(
          height: h,
          width: w * 1,
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ))
              : GoogleMap(
                  // onTap: (argument) {
                  //   Get.back(result: argument);
                  // },
                  markers: Set<Marker>.of(controller.markers),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentPosition!.latitude, currentPosition!.longitude),
                    zoom: 15,
                  ),
                  polylines: Set<Polyline>.of(controller.polylines.values),
                  onMapCreated: (GoogleMapController controllers) {
                    controller.googleMapController.complete(controllers);

                    controllers.moveCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(
                              controller.lat!,
                              controller.long!,
                            ),
                            zoom: 15)));
                  },
                ),
        );
      }),
    );
  }

  GestureDetector buildContainerTile(double height, double width, String title,
      String image, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            )
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                height: height * 0.033,
                width: height * 0.033,
                color: AppColors.grey1Color,
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Text(
                title,
                style: blackMedium14TextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
