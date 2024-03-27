import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/utils/FontSize.dart';
import 'package:wikitrack/views/reports/controller/report_controller.dart';

class DailyTripReportScreen extends StatefulWidget {
  const DailyTripReportScreen({super.key});

  @override
  State<DailyTripReportScreen> createState() => _DailyTripReportScreenState();
}

class _DailyTripReportScreenState extends State<DailyTripReportScreen> {
  ReportController reportController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await reportController.getRouteListViewModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonSubTitleAppBar(
        title: AppStrings.dailyTripReport,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<ReportController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.02,
                ),
                commonBorderButton(
                    title: AppStrings.selectRoute,
                    onTap: () {
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
                                contentPadding:
                                    const EdgeInsets.only(top: 10.0),
                                title: const Text(
                                  AppStrings.selectRoute,
                                  style: TextStyle(fontSize: 24.0),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: SingleChildScrollView(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          commonTextField(
                                            onChanged: (p0) {
                                              controller.searchResult(p0);
                                              setState123(() {});
                                            },
                                            controller:
                                                controller.searchController,
                                            textColor: AppColors.blackColor,
                                            color: AppColors.iconGreyColor,
                                            prefixIcon:
                                                const Icon(Icons.search),
                                          ),
                                          const SizedBox(height: 10),
                                          Expanded(
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Divider(height: 0);
                                              },
                                              itemCount: controller
                                                  .searchDataResults.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () {
                                                    // Get.back();
                                                    controller.setRouteId(
                                                      controller
                                                          .searchDataResults[
                                                              index]
                                                          .routeNo
                                                          .toString(),
                                                      controller
                                                          .searchDataResults[
                                                              index]
                                                          .id
                                                          .toString(),
                                                    );

                                                    setState123(() {});
                                                  },
                                                  title: Builder(
                                                    builder: (context) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              (controller
                                                                          .searchDataResults[
                                                                              index]
                                                                          .routeNo
                                                                          .toString()
                                                                          .isEmpty
                                                                      ? "NA"
                                                                      : controller
                                                                          .searchDataResults[
                                                                              index]
                                                                          .routeNo)
                                                                  .toString()
                                                                  .capitalizeFirst
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Container(
                                                            height: 17,
                                                            width: 17,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: controller
                                                                            .searchDataResults[
                                                                                index]
                                                                            .routeNo
                                                                            .toString() ==
                                                                        controller
                                                                            .selectedRouteId
                                                                            .toString()
                                                                    ? AppColors
                                                                        .primaryColor
                                                                    : AppColors
                                                                        .textGreyColor,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Container(
                                                                height: 17,
                                                                width: 17,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: controller
                                                                              .searchDataResults[
                                                                                  index]
                                                                              .routeNo
                                                                              .toString() ==
                                                                          controller
                                                                              .selectedRouteId
                                                                              .toString()
                                                                      ? AppColors
                                                                          .primaryColor
                                                                      : Colors
                                                                          .transparent,
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
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          /*  controller.isLoading1 == true
                                          ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                          : */
                                          SizedBox(
                                            height: h * 0.05,
                                            child: CommonButton(
                                              title: AppStrings.submit,
                                              onTap: () async {
                                                if (controller
                                                        .selectedRouteId ==
                                                    "") {
                                                  commonSnackBar(
                                                      message:
                                                          'Please select route');
                                                } else {
                                                  if (controller
                                                      .toDateController
                                                      .text
                                                      .isNotEmpty) {
                                                    Get.back();
                                                    controller
                                                        .getRoutesSchedules(
                                                            isDialog: true);
                                                  } else {
                                                    Get.back();
                                                  }
                                                }
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
                  height: h * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          controller.toSelectDate(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.lightGreyColor, width: 1.5)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Date'),
                                Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.07,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "314.0",
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
                                    onChanged: (_) async {
                                      if (controller.selectedRouteId == "") {
                                        commonSnackBar(
                                            message: "Please select route");
                                      } else if (controller
                                          .toDateController.text.isEmpty) {
                                        commonSnackBar(
                                            message: "Please select date");
                                      } else {
                                        controller.changeIsForward();
                                        controller.getRoutesSchedules();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                "314.1",
                                style: blackMedium16TextStyle.copyWith(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                controller.timeSlot.isEmpty
                    ? Text("No slot found")
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.timeSlot.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedSlot = index;
                                    controller.showStopsData(index);
                                    controller.update();
                                  },
                                  child: Container(
                                    height: h * 0.06,
                                    width: w * 0.3,
                                    margin: EdgeInsets.symmetric(
                                        vertical: h * 0.013),
                                    decoration: BoxDecoration(
                                      color: controller.selectedSlot == index
                                          ? AppColors.primaryColor
                                              .withOpacity(0.2)
                                          : AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xff000000)
                                              .withOpacity(0.1),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        SvgPicture.asset(
                                          AppImages.time,
                                          color:
                                              controller.selectedSlot == index
                                                  ? AppColors.primaryColor
                                                  : AppColors.textGreyColor,
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          "${DateFormat('hh:mm a').format(controller.timeSlot[index].dailyrouteTimeslot![0].date!.add(Duration(hours: int.parse(controller.timeSlot[index].time!.split(':')[0]), minutes: int.parse(controller.timeSlot[index].time!.split(':')[1]), seconds: int.parse(controller.timeSlot[index].time!.split(':')[2]))))}",
                                          style: greyMedium14TextStyle.copyWith(
                                            color: const Color(0xff333333),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: w * 0.07,
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.stopsTimeData.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 200),
                                    child: Center(child: Text("No data found")),
                                  )
                                : ListView.builder(
                                    itemCount: controller.stopsTimeData.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: w * 0.03),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .circle_outlined,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  size: 15,
                                                                ),
                                                                Positioned(
                                                                  top: -6,
                                                                  left:
                                                                      w * 0.05,
                                                                  child: Text(
                                                                    "${controller.stopsTimeData[index]['stopName']}",
                                                                    style: primaryBold12TextStyle.copyWith(
                                                                        fontSize:
                                                                            FontSize().font16),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ],
                                                      ),
                                                      const Dash(
                                                          direction:
                                                              Axis.vertical,
                                                          length: 70,
                                                          dashLength: 10,
                                                          dashColor: AppColors
                                                              .lightGreyColor,
                                                          dashGap: 6),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Est.",
                                                            style:
                                                                greyMedium12TextStyle,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .lightGreyColor)),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal: w *
                                                                          0.015,
                                                                      vertical: h *
                                                                          0.003),
                                                              child: Text(
                                                                "${DateFormat('hh:mm a').format(DateTime.parse(controller.stopsTimeData[index]['estimetedTime']))}",
                                                                style:
                                                                    greyMedium12TextStyle,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Act.",
                                                            style:
                                                                greyMedium12TextStyle,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .lightGreyColor)),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal: w *
                                                                          0.015,
                                                                      vertical: h *
                                                                          0.003),
                                                              child: Text(
                                                                "${DateFormat('hh:mm a').format(controller.stopsTimeData[index]['actualTime'])}",
                                                                style:
                                                                    greyMedium12TextStyle,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
