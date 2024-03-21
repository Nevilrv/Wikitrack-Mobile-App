import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/response_model/get_route_list_res_model.dart';
import 'package:wikitrack/response_model/get_stop_display_list_res_model.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppDialog.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/settings/controller/setting_controller.dart';
import 'package:wikitrack/views/settings/routeManagement/map.dart';

class RouteManagement extends StatefulWidget {
  const RouteManagement({Key? key}) : super(key: key);

  @override
  State<RouteManagement> createState() => _RouteManagementState();
}

class _RouteManagementState extends State<RouteManagement> {
  TextEditingController routeId = TextEditingController();

  SettingController settingController = Get.find();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await settingController.getRouteListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      appBar: commonSubTitleAppBar(
        title: AppStrings.routeManage,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      floatingActionButton: GetBuilder<SettingController>(builder: (controller) {
        return GestureDetector(
          onTap: () {
            addNewRouteFloating(context, height, width, controller: controller);
          },
          child: const CircleAvatar(
            // radius: 20,
            backgroundColor: AppColors.primaryColor,
            child: Icon(
              Icons.add,
              color: AppColors.whiteColor,
              size: 25,
            ),
          ),
        );
      }),
      body: GetBuilder<SettingController>(builder: (controller) {
        if (controller.getRouteListResponse.status == Status.LOADING) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (controller.getRouteListResponse.status == Status.COMPLETE) {
          List<RouteResult> results = [RouteResult(), RouteResult()];

          for (var element in controller.searchDataResults1) {
            if (controller.searchDataResults1.isNotEmpty) {
              var d = controller.searchDataResults1
                  .where((ele) =>
                      ele.id.toString() ==
                      (controller.selectedRouteId ?? controller.searchDataResults1[0].id.toString()))
                  .first
                  .routeNo;

              if (d != "") {
                if (element.routeNo == d) {
                  if (element.direction == "1") {
                    results.removeAt(0);
                    results.insert(0, element);
                  } else {
                    results.removeAt(1);
                    results.insert(1, element);
                  }
                }
                log("results--------------> ${results}");
              }
            }
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommonButton(
                          onTap: () {
                            controller.searchResult("");
                            // controller.searchDataResults.clear();
                            controller.searchController.clear();
                            AppDialog().selectRouteDialog(
                              controller: controller,
                              context,
                              title: AppStrings.selectRoute,
                            );
                          },
                          title: AppStrings.selectRoute),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.primaryColor, width: 1.5)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Center(child: Text('Forward')),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.07,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.primaryColor, width: 1.5)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Center(
                                  child: Text('Reverse'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          results[0].stopSequence == null
                              ? const Expanded(
                                  child: Center(
                                    child: Text('No Routes'),
                                  ),
                                )
                              : (results.isNotEmpty && results[0].stopSequence!.isNotEmpty)
                                  ? Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width * 0.03),
                                              child: const Dash(
                                                  direction: Axis.vertical,
                                                  length: 50,
                                                  dashLength: 8,
                                                  dashColor: AppColors.textGreyColor,
                                                  dashGap: 4),
                                            ),
                                          );
                                        },
                                        itemCount: results[0].stopSequence!.length + 1,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return (index == results[0].stopSequence!.length)
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    await settingController.getStopListViewModel();
                                                    await settingController.getStopDisplayListViewModel();
                                                    if (!mounted) return;
                                                    addNewStop(
                                                      priority: index,
                                                      context: context,
                                                      height: height,
                                                      width: width,
                                                      controller: controller,
                                                      direction: results[0].direction.toString(),
                                                      routId: results[0].id.toString(),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.add_circle_outline_sharp,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.02,
                                                      ),
                                                      Text(
                                                        AppStrings.addStop,
                                                        style: blackMedium16TextStyle,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle_outlined,
                                                          color: AppColors.primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: Get.width * 0.02,
                                                        ),
                                                        Text(
                                                          "${results[0].stopSequence?[index].stopId?.name.toString().capitalizeFirst}",
                                                          style: blackMedium16TextStyle,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        },
                                      ),
                                    )
                                  : Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: width * 0.03),
                                            child: const Dash(
                                                direction: Axis.vertical,
                                                length: 50,
                                                dashLength: 8,
                                                dashColor: AppColors.textGreyColor,
                                                dashGap: 4),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await settingController.getStopListViewModel();
                                              await settingController.getStopDisplayListViewModel();

                                              if (!mounted) return;

                                              addNewStop(
                                                priority: 0,
                                                context: context,
                                                height: height,
                                                width: width,
                                                controller: controller,
                                                direction: results[0].direction.toString(),
                                                routId: results[0].id.toString(),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.add_circle_outline_sharp,
                                                  color: AppColors.primaryColor,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Text(
                                                  AppStrings.addStop,
                                                  style: blackMedium16TextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          results[1].stopSequence == null
                              ? const Expanded(
                                  child: Center(
                                    child: Text('No Routes'),
                                  ),
                                )
                              : (results.length >= 2 && results[1].stopSequence!.isNotEmpty)
                                  ? Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width * 0.03),
                                              child: const Dash(
                                                  direction: Axis.vertical,
                                                  length: 50,
                                                  dashLength: 8,
                                                  dashColor: AppColors.textGreyColor,
                                                  dashGap: 4),
                                            ),
                                          );
                                        },
                                        itemCount: results[1].stopSequence!.length + 1,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return (index == results[1].stopSequence!.length)
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    await settingController.getStopListViewModel();
                                                    await settingController.getStopDisplayListViewModel();

                                                    if (!mounted) return;

                                                    addNewStop(
                                                      priority: index,
                                                      context: context,
                                                      height: height,
                                                      width: width,
                                                      controller: controller,
                                                      direction: results[1].direction.toString(),
                                                      routId: results[1].id.toString(),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.add_circle_outline_sharp,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.02,
                                                      ),
                                                      Text(
                                                        AppStrings.addStop,
                                                        style: blackMedium16TextStyle,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle_outlined,
                                                          color: AppColors.primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: Get.width * 0.02,
                                                        ),
                                                        Text(
                                                          "${results[1].stopSequence?[index].stopId?.name.toString().capitalizeFirst}",
                                                          style: blackMedium16TextStyle,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        },
                                      ),
                                    )
                                  : /*results.length == 1
                                  ? const Expanded(
                                      child: Center(
                                        child: Text('No Routes'),
                                      ),
                                    )
                                  : */
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: width * 0.03),
                                            child: const Dash(
                                                direction: Axis.vertical,
                                                length: 50,
                                                dashLength: 8,
                                                dashColor: AppColors.textGreyColor,
                                                dashGap: 4),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await settingController.getStopListViewModel();
                                              await settingController.getStopDisplayListViewModel();

                                              if (!mounted) return;

                                              addNewStop(
                                                priority: 0,
                                                context: context,
                                                height: height,
                                                width: width,
                                                controller: controller,
                                                direction: results[1].direction.toString(),
                                                routId: results[1].id.toString(),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.add_circle_outline_sharp,
                                                  color: AppColors.primaryColor,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Text(
                                                  AppStrings.addStop,
                                                  style: blackMedium16TextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              controller.getStopDisplayListResponse.status == Status.LOADING ||
                      controller.getStopListResponse.status == Status.LOADING
                  ? Container(
                      height: height,
                      width: width,
                      color: AppColors.primaryColor.withOpacity(0.2),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        } else if (controller.getRouteListResponse.status == Status.ERROR) {
          return const Center(child: Text('Server error'));
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      }),
    );
  }

  Future<void> addNewStop({
    required BuildContext context,
    required double height,
    required double width,
    required SettingController controller,
    String? direction,
    String? routId,
    int? priority,
  }) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          GetStopDisplayListResModel stopData = controller.getStopDisplayListResponse.data;
          log('stopData===>>>${jsonEncode(stopData)}');

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: IntrinsicHeight(
              // height: height * 0.7,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: height * 0.01,
                          width: width * 0.09,
                          decoration: BoxDecoration(
                              color: AppColors.grey2Color.withOpacity(0.5), borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        AppStrings.addStop,
                        style: blackMedium16TextStyle,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        AppStrings.stop,
                        style: grey1Medium12TextStyle,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonTextField(
                        onTap: () {
                          AppDialog().selectStopDialog(context, title: 'Select Stop', controller: controller);
                        },
                        hintMsg: 'Select Stop',
                        textColor: AppColors.blackColor,
                        controller: controller.stop,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Row(
                        children: [
                          Text(
                            AppStrings.latLong,
                            style: greyMedium12TextStyle,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              addNewRouteFromAddStop(context, height, width, controller: controller);
                            },
                            child: Text(
                              AppStrings.addNewRoute,
                              style: greyMedium12TextStyle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        AppStrings.travelTime,
                        style: grey1Medium12TextStyle,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonTextField(
                        readOnly: true,
                        hintMsg: 'Select Time',
                        textColor: AppColors.blackColor,
                        controller: controller.travelTime,
                        onTap: () {
                          controller.selectTime(context);
                        },
                      ),
                      /* SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        AppStrings.stopDevice,
                        style: grey1Medium12TextStyle,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonTextField(
                        controller: controller.stopDevice,
                        textColor: AppColors.blackColor,
                        readOnly: true,
                        hintMsg: 'Select Stop Device',
                        onTap: () {
                          AppDialog().selectStopDisplayDialog(context,
                              title: 'Select Stop Device',
                              controller: controller);
                        },
                      ),*/
                      SizedBox(
                        height: height * 0.05,
                      ),
                      controller.createStopSeqResponse.status == Status.LOADING
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : CommonButton(
                              onTap: () async {
                                if (controller.stopId == "" ||
                                    controller.stop.text.isEmpty ||
                                    controller.travelTime.text.isEmpty) {
                                  commonSnackBar(message: "Please enter all the details");
                                  return;
                                }

                                var body = {
                                  "route": "$routId",
                                  "priority": (priority ?? 0) + 1,
                                  "traval_time": controller.travelTime.text.toString(),
                                  "stop_id": controller.stopId.toString(),
                                  "status": true,
                                  "direction": "$direction"
                                };
                                log('body===body>>>$body');

                                await controller.createStopSeqViewModel(body: body);
                                controller.clearAddStopSeq();
                                Get.back();
                                getData();
                              },
                              title: AppStrings.submit),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).then((value) => controller.clearAddStopSeq());
  }

  void addNewRouteFromAddStop(BuildContext context, double height, double width,
      {required SettingController controller}) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          if (settingController.getStopDisplayListResponse.status == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          }
          if (settingController.getStopDisplayListResponse.status == Status.COMPLETE) {
            var data = settingController.getStopDisplayListResponse.data;
            log('data::::::::::::::::::::==========>>>>>>>>>>>$data');
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: height * 0.75,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: height * 0.01,
                            width: width * 0.09,
                            decoration: BoxDecoration(
                                color: AppColors.grey2Color.withOpacity(0.5), borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Text(
                          AppStrings.addNewStop,
                          style: blackMedium16TextStyle,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          AppStrings.stopDisplay,
                          style: grey1Medium12TextStyle,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        commonTextField(
                          controller: controller.stopDevice,
                          textColor: AppColors.blackColor,
                          readOnly: true,
                          hintMsg: 'Select Stop Display',
                          onTap: () {
                            AppDialog()
                                .selectStopDisplayDialog(context, title: 'Select Stop Display', controller: controller);
                          },
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          AppStrings.stopno,
                          style: grey1Medium12TextStyle,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        commonTextField(
                          controller: controller.stopNo,
                          textColor: Colors.black,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          AppStrings.stopName,
                          style: grey1Medium12TextStyle,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        commonTextField(
                          textColor: Colors.black,
                          controller: controller.stopName,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          AppStrings.lat,
                          style: grey1Medium12TextStyle,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        commonTextField(
                          readOnly: true,
                          controller: controller.latLangController,
                          textColor: Colors.black,
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Get.to(() => const MapScreen())?.then((value) {
                              if (value != null) {
                                LatLng data = value;
                                controller.latLangController.text = "${data.latitude},${data.longitude}";
                              }
                              return;
                            });
                          },
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        controller.createStopResponse.status == Status.LOADING
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : CommonButton(
                                onTap: () async {
                                  print('controller.stopDisplayId == ""===>>>${controller.stopDisplayId == ""}');

                                  if (controller.stopDisplayId == "" ||
                                      controller.stopNo.text.isEmpty ||
                                      controller.stopName.text.isEmpty ||
                                      controller.latLangController.text.isEmpty) {
                                    commonSnackBar(message: "Please enter all the details");
                                    return;
                                  }

                                  var body = {
                                    "stop_no": controller.stopNo.text,
                                    "name": controller.stopName.text,
                                    "stop_display": controller.stopDisplayId,
                                    "location": controller.latLangController.text,
                                    "status": false
                                  };
                                  log('body===body>>>$body');

                                  await controller.createStopViewModel(body: body);
                                  controller.clearAddNewStop();
                                  Get.back();
                                  getData();
                                },
                                title: AppStrings.submit),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        }).then((value) => controller.clearAddNewStop());
  }

  Future<void> addNewRouteFloating(BuildContext context, double height, double width,
      {required SettingController controller}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: height * 0.65),
                // height: height * 0.4,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: height * 0.01,
                              width: width * 0.09,
                              decoration: BoxDecoration(
                                  color: AppColors.grey2Color.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Text(
                            AppStrings.addNewRoute,
                            style: blackMedium16TextStyle,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            AppStrings.routeno,
                            style: grey1Medium12TextStyle,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          commonTextField(
                            keyboardType: TextInputType.number,
                            controller: controller.routeNo,
                            textColor: Colors.black,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            AppStrings.routeName,
                            style: grey1Medium12TextStyle,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          commonTextField(
                            textColor: Colors.black,
                            controller: controller.routeName,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            AppStrings.direction,
                            style: grey1Medium12TextStyle,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),

                          Row(
                            children: [
                              Text(
                                "Forward",
                                style: blackMedium16TextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: height * 0.04,
                                width: width * 0.13,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CupertinoSwitch(
                                    activeColor: AppColors.iconBlueColor,
                                    thumbColor: AppColors.whiteColor,
                                    trackColor: AppColors.iconBlueColor,
                                    value: controller.isForward1,
                                    onChanged: (value) async {
                                      await controller.changeIsForward1();
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                "Reverse",
                                style: blackMedium16TextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),

                          // commonTextField(
                          //   textColor: Colors.black,
                          //   controller: controller.direction,
                          // ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          CommonButton(
                              onTap: () async {
                                String v = controller.isForward1 ? "0" : "1";
                                bool value = controller.searchDataResults.any((element) =>
                                    element.routeNo.toString() == controller.routeNo.text &&
                                    (element.direction.toString() == v));
                                // log("element.direction--------------> ${element.direction}");

                                // String v = controller.isForward1 ? "0" : "1";
                                // bool value1 =
                                //     controller.searchDataResults.any((element) => element.direction.toString() == v);

                                if (controller.routeNo.text.isEmpty || controller.routeName.text.isEmpty) {
                                  commonSnackBar(message: "Please enter all the details");
                                  return;
                                }

                                log("value--------------> ${value}");

                                if (value == true) {
                                  commonSnackBar(
                                      message:
                                          "Route number or direction already exist. Please try with another route no or direction");
                                  return;
                                } else {
                                  var body = {
                                    "route_no": controller.routeNo.text,
                                    "name": controller.routeName.text,
                                    "direction": controller.isForward1 ? "0" : "1",
                                    "status": false
                                  };

                                  await controller.createRouteViewModel(body: body);
                                  await controller.clearRoute();
                                  Get.back();
                                  getData();
                                }
                              },
                              title: AppStrings.submit),
                        ],
                      ),
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
