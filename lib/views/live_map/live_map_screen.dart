import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_marker_animation/widgets/animarker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/common/commontextfield.dart';

import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/socket/socket_service.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/live_map/controller/live_map_controller.dart';

class LiveMapScreen extends StatefulWidget {
  const LiveMapScreen({super.key});

  @override
  State<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen> with WidgetsBindingObserver {
  // SettingController settingController = Get.find();
  LiveMapController liveMapController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    SocketConnection.connectSocket(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        liveMapController.getCurrentPosition();
        await liveMapController.getVehicleListViewModel();
        await liveMapController.getRouteListViewModel();
        double distanceInMeters = Geolocator.distanceBetween(21.218401, 72.8792374, 21.1781093, 72.5882196);
        log("distanceInMeters--------------> ${distanceInMeters}");
      });
      liveMapController.getSocketLiveMapData();
      liveMapController.getLiveMapDataListener();
      print("socket connection----");
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        SocketConnection.connectSocket(() {
          liveMapController.getSocketLiveMapData();
          liveMapController.getLiveMapDataListener();
          print("socket connection----");
        });
        log('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        SocketConnection.socketDisconnect();
        log('appLifeCycleState paused');
        break;
      case AppLifecycleState.hidden:
        log('appLifeCycleState suspending');
        break;
      case AppLifecycleState.detached:
        log('appLifeCycleState detached');
        break;
    }
  }

  @override
  void dispose() {
    SocketConnection.socketDisconnect();
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonSubTitleAppBar(
        title: AppStrings.liveMap,
        subTitle: AppStrings.bmtc,
        actions: [
          GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return GetBuilder<LiveMapController>(
                      builder: (controller) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return IntrinsicHeight(
                              child: Container(
                                // height: h * 0.3,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          height: h * 0.03,
                                        ),
                                        buildContainerTile(h, w, AppStrings.byRoute, AppImages.routeManage, () {
                                          controller.searchResult("");
                                          controller.searchController.clear();
                                          controller.stopSequence.clear();
                                          controller.isForward = false;
                                          controller.isLoading1 = false;
                                          controller.selectedRouteId = '';
                                          controller.update();
                                          setState(() {});
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
                                                    title: const Text(
                                                      AppStrings.selectRoute,
                                                      style: TextStyle(fontSize: 24.0),
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
                                                                child: ListView.separated(
                                                                  separatorBuilder: (context, index) {
                                                                    return const Divider(height: 0);
                                                                  },
                                                                  itemCount: controller.searchDataResults.length,
                                                                  shrinkWrap: true,
                                                                  itemBuilder: (context, index) {
                                                                    return ListTile(
                                                                      onTap: () {
                                                                        // Get.back();
                                                                        controller.setRouteId(
                                                                          controller.searchDataResults[index].routeNo
                                                                              .toString(),
                                                                          controller.searchDataResults[index].id
                                                                              .toString(),
                                                                        );
                                                                        controller.stopSequence.clear();
                                                                        controller.update();
                                                                        if (controller.searchDataResults[index]
                                                                            .stopSequence!.isNotEmpty) {
                                                                          controller.stopSequence.addAll(controller
                                                                              .searchDataResults[index]
                                                                              .stopSequence as Iterable<StopSequence>);
                                                                        }
                                                                        setState123(() {});
                                                                        log("controller.stopSequence--------------> ${controller.stopSequence}");
                                                                      },
                                                                      title: Builder(
                                                                        builder: (context) {
                                                                          return Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Flexible(
                                                                                child: Text(
                                                                                  (controller.searchDataResults[index]
                                                                                              .name
                                                                                              .toString()
                                                                                              .isEmpty
                                                                                          ? "NA"
                                                                                          : controller
                                                                                              .searchDataResults[index]
                                                                                              .name)
                                                                                      .toString()
                                                                                      .capitalizeFirst
                                                                                      .toString(),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 5),
                                                                              Container(
                                                                                height: 17,
                                                                                width: 17,
                                                                                padding: const EdgeInsets.all(2),
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  border: Border.all(
                                                                                    color: controller
                                                                                                .searchDataResults[
                                                                                                    index]
                                                                                                .routeNo
                                                                                                .toString() ==
                                                                                            controller.selectedRouteId
                                                                                                .toString()
                                                                                        ? AppColors.primaryColor
                                                                                        : AppColors.textGreyColor,
                                                                                    width: 2,
                                                                                  ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Container(
                                                                                    height: 17,
                                                                                    width: 17,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                      color: controller
                                                                                                  .searchDataResults[
                                                                                                      index]
                                                                                                  .routeNo
                                                                                                  .toString() ==
                                                                                              controller.selectedRouteId
                                                                                                  .toString()
                                                                                          ? AppColors.primaryColor
                                                                                          : Colors.transparent,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Text(
                                                                AppStrings.direction,
                                                                style: textGreyMedium16TextStyle,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Forward",
                                                                    style: blackMedium16TextStyle.copyWith(
                                                                        fontWeight: FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    height: h * 0.04,
                                                                    width: w * 0.13,
                                                                    child: FittedBox(
                                                                      fit: BoxFit.fill,
                                                                      child: CupertinoSwitch(
                                                                        activeColor: AppColors.iconBlueColor,
                                                                        thumbColor: AppColors.whiteColor,
                                                                        trackColor: AppColors.iconBlueColor,
                                                                        value: controller.isForward,
                                                                        onChanged: (value) async {
                                                                          await controller.changeIsForward();
                                                                          setState123(() {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Reverse",
                                                                    style: blackMedium16TextStyle.copyWith(
                                                                        fontWeight: FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: h * 0.005,
                                                              ),
                                                              controller.isLoading1 == true
                                                                  ? const Center(
                                                                      child: CircularProgressIndicator(
                                                                        color: AppColors.primaryColor,
                                                                      ),
                                                                    )
                                                                  : SizedBox(
                                                                      height: h * 0.05,
                                                                      child: CommonButton(
                                                                        title: AppStrings.submit,
                                                                        onTap: () async {
                                                                          if (controller.selectedRouteId == "") {
                                                                            commonSnackBar(
                                                                                message: 'Please select route');
                                                                          } else {
                                                                            await controller.getDailyRouteTripViewModel(
                                                                                setState123);

                                                                            if (controller.isLoading1 == false) {
                                                                              showModalBottomSheet<void>(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return Stack(children: [
                                                                                    Container(
                                                                                      height: h * 0.3,
                                                                                      decoration: BoxDecoration(
                                                                                        color: AppColors.primaryColor,
                                                                                        borderRadius:
                                                                                            BorderRadius.circular(20),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                            top: h * 0.07),
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: AppColors.whiteColor,
                                                                                            borderRadius:
                                                                                                BorderRadius.circular(
                                                                                                    20),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                        right: w * 0.05,
                                                                                        left: w * 0.03,
                                                                                        top: h * 0.02,
                                                                                        // bottom: 0,
                                                                                        child: Column(
                                                                                          crossAxisAlignment:
                                                                                              CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              "${controller.selectedRouteId}",
                                                                                              style:
                                                                                                  whiteMedium16TextStyle,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h * 0.05,
                                                                                            ),
                                                                                            Center(
                                                                                              child: Text(
                                                                                                "${controller.selectedRouteId}",
                                                                                                style:
                                                                                                    blackMedium16TextStyle,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h * 0.01,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h * 0.01,
                                                                                            ),
                                                                                            Center(
                                                                                              child:
                                                                                                  SingleChildScrollView(
                                                                                                scrollDirection:
                                                                                                    Axis.horizontal,
                                                                                                child: Row(
                                                                                                  crossAxisAlignment:
                                                                                                      CrossAxisAlignment
                                                                                                          .end,
                                                                                                  mainAxisAlignment:
                                                                                                      MainAxisAlignment
                                                                                                          .center,
                                                                                                  children: List.generate(
                                                                                                      controller
                                                                                                              .stopSequence
                                                                                                              .isEmpty
                                                                                                          ? 0
                                                                                                          : controller
                                                                                                              .stopSequence
                                                                                                              .length,
                                                                                                      (index) {
                                                                                                    return Column(
                                                                                                      mainAxisAlignment:
                                                                                                          MainAxisAlignment
                                                                                                              .start,
                                                                                                      crossAxisAlignment:
                                                                                                          CrossAxisAlignment
                                                                                                              .start,
                                                                                                      children: [
                                                                                                        Row(
                                                                                                          children: List.generate(
                                                                                                              controller
                                                                                                                      .routeBusStopsData
                                                                                                                      .isEmpty
                                                                                                                  ? 0
                                                                                                                  : controller.routeBusStopsData[controller.routeBusStopsData.indexWhere((element) =>
                                                                                                                      element["stop_id"] ==
                                                                                                                      controller.stopSequence[index].stopId?.id)]["count"],
                                                                                                              (index1) {
                                                                                                            return SvgPicture.asset(
                                                                                                                AppImages
                                                                                                                    .bus2);
                                                                                                          }),
                                                                                                        ),
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            CircleAvatar(
                                                                                                              radius: w *
                                                                                                                  0.023,
                                                                                                              backgroundColor:
                                                                                                                  AppColors
                                                                                                                      .textGreyColor,
                                                                                                            ),
                                                                                                            controller.stopSequence.length ==
                                                                                                                    index +
                                                                                                                        1
                                                                                                                ? const SizedBox()
                                                                                                                : const Dash(
                                                                                                                    direction: Axis
                                                                                                                        .horizontal,
                                                                                                                    length:
                                                                                                                        10,
                                                                                                                    dashLength:
                                                                                                                        5,
                                                                                                                    dashColor:
                                                                                                                        AppColors.textGreyColor,
                                                                                                                    dashGap: 5),
                                                                                                          ],
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height:
                                                                                                              h * 0.005,
                                                                                                        ),
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            SizedBox(
                                                                                                              height: h *
                                                                                                                  0.07,
                                                                                                              child:
                                                                                                                  RotatedBox(
                                                                                                                quarterTurns:
                                                                                                                    -1,
                                                                                                                child: Text(
                                                                                                                    maxLines:
                                                                                                                        1,
                                                                                                                    overflow:
                                                                                                                        TextOverflow.ellipsis,
                                                                                                                    '${controller.stopSequence[index].stopId!.name}',
                                                                                                                    style: blackMedium14TextStyle),
                                                                                                              ),
                                                                                                            ),
                                                                                                            const SizedBox(
                                                                                                                width:
                                                                                                                    8)
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    );
                                                                                                  }),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h * 0.005,
                                                                                            ),
                                                                                            // Center(
                                                                                            //   child: Padding(
                                                                                            //     padding:
                                                                                            //         const EdgeInsets.only(
                                                                                            //             left: 5),
                                                                                            //     child:
                                                                                            //         SingleChildScrollView(
                                                                                            //       scrollDirection:
                                                                                            //           Axis.horizontal,
                                                                                            //       child: Row(
                                                                                            //         mainAxisAlignment:
                                                                                            //             MainAxisAlignment
                                                                                            //                 .center,
                                                                                            //         children:
                                                                                            //             List.generate(
                                                                                            //                 controller
                                                                                            //                     .stopSequence
                                                                                            //                     .length,
                                                                                            //                 (index) =>
                                                                                            //                     Row(
                                                                                            //                       children: [
                                                                                            //                         RotatedBox(
                                                                                            //                           quarterTurns:
                                                                                            //                               -1,
                                                                                            //                           child:
                                                                                            //                               Text('Stop ${controller.stopSequence[index].stopId!.stopNo}', style: blackMedium14TextStyle),
                                                                                            //                         ),
                                                                                            //                         SizedBox(
                                                                                            //                             width: 8)
                                                                                            //                       ],
                                                                                            //                     )),
                                                                                            //       ),
                                                                                            //     ),
                                                                                            //   ),
                                                                                            // ),
                                                                                          ],
                                                                                        )),
                                                                                  ]);
                                                                                },
                                                                              );
                                                                            }
                                                                          }
                                                                          // LiveMapRepo().getDailyRouteTripFilter();
                                                                        },
                                                                      ),
                                                                    )
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
                                        }),
                                        SizedBox(
                                          height: h * 0.03,
                                        ),
                                        buildContainerTile(h, w, AppStrings.byVehicle, AppImages.vehicleManage, () {
                                          controller.searchId = "";
                                          controller.selector = 0;
                                          controller.loading3 = false;
                                          setState(() {});

                                          TextEditingController search = TextEditingController();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, setState1) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                          20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    contentPadding: const EdgeInsets.only(
                                                      top: 10.0,
                                                    ),
                                                    title: const Text(
                                                      AppStrings.selectVehicle,
                                                      style: TextStyle(fontSize: 24.0),
                                                    ),
                                                    content: SingleChildScrollView(
                                                      child: SizedBox(
                                                        height: MediaQuery.of(context).size.height * 0.5,
                                                        width: MediaQuery.of(context).size.width * 0.9,
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 10, vertical: 10),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  commonTextField(
                                                                    controller: search,
                                                                    prefixIcon: const Icon(Icons.search),
                                                                    textColor: AppColors.blackColor,
                                                                    color: AppColors.iconGreyColor,
                                                                    onChanged: (value) {
                                                                      controller.searchStopResult(value);
                                                                      setState1(() {});
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: ListView.separated(
                                                                      separatorBuilder: (context, index) {
                                                                        return const Divider(height: 0);
                                                                      },
                                                                      itemCount: controller.searchData.length,
                                                                      shrinkWrap: true,
                                                                      itemBuilder: (context, index) {
                                                                        return ListTile(
                                                                          onTap: () async {
                                                                            controller.stopSequence.clear();

                                                                            controller.update();

                                                                            controller.searchId =
                                                                                controller.searchData[index].regNo ??
                                                                                    '';

                                                                            controller.selector = controller.searchData
                                                                                .indexWhere((element) =>
                                                                                    element.id ==
                                                                                    controller.searchData[index].id);

                                                                            await controller.getStopTimeByRegNo(
                                                                                regNo: controller.searchId);

                                                                            await controller.getVehicleRouteList(
                                                                                controller.searchId, setState1);

                                                                            if (controller.loading3 == false) {
                                                                              showModalBottomSheet<void>(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return Stack(children: [
                                                                                    Container(
                                                                                      height: h * 0.3,
                                                                                      decoration: BoxDecoration(
                                                                                        color: AppColors.primaryColor,
                                                                                        borderRadius:
                                                                                            BorderRadius.circular(20),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                            top: h * 0.07),
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: AppColors.whiteColor,
                                                                                            borderRadius:
                                                                                                BorderRadius.circular(
                                                                                                    20),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                        right: w * 0.05,
                                                                                        left: w * 0.03,
                                                                                        top: h * 0.02,
                                                                                        // bottom: 0,
                                                                                        child: Column(
                                                                                          crossAxisAlignment:
                                                                                              CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              "${controller.searchId}",
                                                                                              style:
                                                                                                  whiteMedium16TextStyle,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h * 0.05,
                                                                                            ),
                                                                                            Center(
                                                                                              child: Text(
                                                                                                "${controller.searchId}",
                                                                                                style:
                                                                                                    blackMedium16TextStyle,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h * 0.01,
                                                                                            ),
                                                                                            Center(
                                                                                              child: Row(
                                                                                                crossAxisAlignment:
                                                                                                    CrossAxisAlignment
                                                                                                        .center,
                                                                                                mainAxisAlignment:
                                                                                                    MainAxisAlignment
                                                                                                        .center,
                                                                                                children: List.generate(
                                                                                                    controller
                                                                                                        .stopSequence
                                                                                                        .length,
                                                                                                    (index) => Row(
                                                                                                          children: [
                                                                                                            CircleAvatar(
                                                                                                              radius: w *
                                                                                                                  0.023,
                                                                                                              backgroundColor: /*index == 6 ||
                                                                                                                      index ==
                                                                                                                          7 ||
                                                                                                                      index ==
                                                                                                                          8 ||
                                                                                                                      index ==
                                                                                                                          9 ||
                                                                                                                      index ==
                                                                                                                          10
                                                                                                                  ? AppColors
                                                                                                                      .primaryColor
                                                                                                                  : */
                                                                                                                  controller.stopSequence.indexWhere((element) => element.stopId?.id.toString() == controller.busStopDataIds[0].toString()) >= index
                                                                                                                      // controller.busStopDataIds[0] == controller.stopSequence[index].stopId?.id.toString()
                                                                                                                      ? AppColors.textGreyColor
                                                                                                                      : AppColors.primaryColor,
                                                                                                            ),
                                                                                                            index + 1 ==
                                                                                                                    controller
                                                                                                                        .stopSequence.length
                                                                                                                ? const SizedBox()
                                                                                                                : const Dash(
                                                                                                                    direction: Axis
                                                                                                                        .horizontal,
                                                                                                                    length:
                                                                                                                        12,
                                                                                                                    dashLength:
                                                                                                                        3,
                                                                                                                    dashColor:
                                                                                                                        AppColors.textGreyColor,
                                                                                                                    dashGap: 3),
                                                                                                          ],
                                                                                                        )),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: h * 0.005,
                                                                                            ),
                                                                                            Center(
                                                                                              child: Padding(
                                                                                                padding:
                                                                                                    const EdgeInsets
                                                                                                        .only(left: 5),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment:
                                                                                                      MainAxisAlignment
                                                                                                          .center,
                                                                                                  children:
                                                                                                      List.generate(
                                                                                                          controller
                                                                                                              .stopSequence
                                                                                                              .length,
                                                                                                          (index) =>
                                                                                                              Row(
                                                                                                                children: [
                                                                                                                  SizedBox(
                                                                                                                    height:
                                                                                                                        h * 0.07,
                                                                                                                    child:
                                                                                                                        RotatedBox(
                                                                                                                      quarterTurns: -1,
                                                                                                                      child: Text(maxLines: 1, overflow: TextOverflow.ellipsis, '${controller.stopSequence[index].stopId!.name}', style: blackMedium14TextStyle),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                      width: 8)
                                                                                                                ],
                                                                                                              )),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        )),
                                                                                  ]);
                                                                                },
                                                                              );
                                                                            }
                                                                          },
                                                                          title: Text(
                                                                              controller.searchData[index].regNo ?? ''),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  // CommonButton(title: AppStrings.add)
                                                                ],
                                                              ),
                                                            ),
                                                            controller.loading3 == true
                                                                ? Container(
                                                                    // height: h,
                                                                    // width: w,
                                                                    color: Colors.black12,
                                                                    child: const Center(
                                                                        child: CircularProgressIndicator(
                                                                      color: AppColors.primaryColor,
                                                                    )))
                                                                : const SizedBox()
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }),
                                        SizedBox(
                                          height: h * 0.03,
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
                  },
                );
              },
              child: SvgPicture.asset(AppImages.menuIcon)),
          SizedBox(
            width: w * 0.05,
          )
        ],
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<LiveMapController>(
        builder: (controller) {
          return controller.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ))
              : GoogleMap(
                  onTap: (argument) {
                    Get.back(result: argument);
                  },
                  markers: Set<Marker>.of(controller.markers),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(controller.lat!, controller.long!),
                    zoom: 15,
                  ),
                  polylines: Set<Polyline>.of(controller.polylines.values),
                  onMapCreated: (GoogleMapController controllers) {
                    controller.googleMapController.complete(controllers);

                    controllers.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(
                          controller.lat!,
                          controller.long!,
                        ),
                        zoom: 15)));
                  },
                );
        },
      ),
    );
  }

  GestureDetector buildContainerTile(double height, double width, String title, String image, Function() onTap) {
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
              SvgPicture.asset(image, height: height * 0.033, width: height * 0.033),
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
