import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/utils/app_colors.dart';
import 'package:wikitrack/utils/app_dialog.dart';
import 'package:wikitrack/utils/app_font_style.dart';
import 'package:wikitrack/utils/app_strings.dart';
import 'package:wikitrack/views/settings/controller/setting_controller.dart';

import '../../../common/common_snackbar.dart';

class BusTimeTable extends StatefulWidget {
  const BusTimeTable({super.key});

  @override
  State<BusTimeTable> createState() => _RountineTripManagementState();
}

class _RountineTripManagementState extends State<BusTimeTable> {
  SettingController settingController = Get.find();

  bool isSwitch = false;
  bool isSwitch1 = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await settingController.getRouteListViewModel();
  }

  List<DateTime?> temp = [
    DateTime(2024, 1, 1),
    DateTime(2024, 1, 13),
  ];
  List<DateTime?> selectedDate = [
    DateTime.now(),
  ];
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return GetBuilder<SettingController>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: commonSubTitleAppBar(
            title: AppStrings.routineTripManage,
            subTitle: AppStrings.bmtc,
            onTap: () {
              Get.back();
            },
          ),
          floatingActionButton: /*controller.busTimeTableData.isEmpty
              ? const SizedBox()
              : */
              controller.selectedRouteId != null
                  ? GestureDetector(
                      onTap: () {
                        buildShowModalBottomSheet(context, height, width);
                      },
                      child: const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 25,
                        ),
                      ),
                    )
                  : SizedBox(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  commonBorderButton(
                    title: AppStrings.selectRoute,
                    onTap: () {
                      AppDialog().selectRouteDialog(
                        controller: controller,
                        from: 'bus_time_table',
                        context,
                        isTrip: false,
                        title: AppStrings.selectRoute,
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  if (controller.selectedRouteId != null)
                    Row(
                      children: [
                        Text(
                          "Forward",
                          style: blackMedium16TextStyle.copyWith(
                              fontWeight: FontWeight.w500),
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
                              value: controller.isForward,
                              onChanged: (_) async {
                                controller.changeIsForward();
                                if (controller.selectedRouteId != null) {
                                  controller.busTimeTableData.clear();
                                  await controller.busTimeTableViewModel(
                                    routeId: controller.searchDataResults1
                                        .where((element) =>
                                            element.id ==
                                            controller.selectedRouteId)
                                        .first
                                        .routeNo
                                        .toString()
                                        .replaceAll(" ", "%20"),
                                    direction: controller.isForward ? "0" : "1",
                                  );

                                  bool isMatch = false;
                                  String id = "";
                                }
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
                  SizedBox(height: height * 0.02),
                  if (controller.selectedRouteId != null)
                    Builder(
                      builder: (context) {
                        if (controller.getBusTimeTableResponse.status ==
                            Status.LOADING) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )).paddingOnly(top: height * 0.3);
                        } else if (controller.getBusTimeTableResponse.status ==
                            Status.ERROR) {
                          return const Center(child: Text("Server Error"))
                              .paddingOnly(top: height * 0.3);
                        } else if (controller.getBusTimeTableResponse.status ==
                            Status.COMPLETE) {
                          return controller.busTimeTableData.isNotEmpty
                              ? Column(
                                  children: [
                                    ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: height * 0.02);
                                      },
                                      itemCount: controller.busTimeTableData
                                          .first.daySlot!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 12,
                                                  child: commonBorderButton(
                                                    borderColor: AppColors
                                                        .lightGreyColor,
                                                    color: AppColors
                                                        .lightGreyColor,
                                                    title: controller
                                                        .busTimeTableData
                                                        .first
                                                        .daySlot![index]
                                                        .day,
                                                    textColor:
                                                        AppColors.blackColor,
                                                    onTap: () {
                                                      controller
                                                          .isVisible(index);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await controller
                                                          .selectTime(context);

                                                      if (controller
                                                              .selectedTime ==
                                                          null) {
                                                        return;
                                                      }

                                                      await controller
                                                          .createBusTimeSlotViewModel(
                                                              body: {
                                                            "dayslot": controller
                                                                .busTimeTableData
                                                                .first
                                                                .daySlot?[index]
                                                                .id,
                                                            "time":
                                                                "${controller.selectedTime?.hour}:${controller.selectedTime?.minute}",
                                                            "status": false
                                                          });
                                                      controller.selectedTime =
                                                          null;
                                                      controller
                                                          .busTimeTableData
                                                          .clear();
                                                      await controller
                                                          .busTimeTableViewModel(
                                                        routeId: controller
                                                            .searchDataResults
                                                            .where((element) =>
                                                                element.id ==
                                                                controller
                                                                    .selectedRouteId)
                                                            .first
                                                            .routeNo
                                                            .toString()
                                                            .replaceAll(
                                                                " ", "%20"),
                                                        direction:
                                                            controller.isForward
                                                                ? "0"
                                                                : "1",
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primaryColor),
                                                      ),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: controller
                                                  .busTimeTableData
                                                  .first
                                                  .daySlot![index]
                                                  .isVisible,
                                              child: controller
                                                      .busTimeTableData
                                                      .first
                                                      .daySlot![index]
                                                      .timeSlot!
                                                      .isEmpty
                                                  ? const Center(
                                                          child: Text(
                                                              "No Time Slot"))
                                                      .paddingOnly(
                                                          top: height * 0.02)
                                                  : GridView.builder(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.02),
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                          .busTimeTableData
                                                          .first
                                                          .daySlot![index]
                                                          .timeSlot
                                                          ?.length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              mainAxisExtent:
                                                                  height *
                                                                      0.065),
                                                      itemBuilder:
                                                          (context, iii) {
                                                        DateTime time = DateFormat(
                                                                "HH:mm")
                                                            .parse(controller
                                                                .busTimeTableData
                                                                .first
                                                                .daySlot![index]
                                                                .timeSlot![iii]
                                                                .time
                                                                .toString());
                                                        String formattedTime =
                                                            DateFormat("HH:mm")
                                                                .format(time);

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: AppColors
                                                                        .blackColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                    blurRadius:
                                                                        4,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            2))
                                                              ],
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .access_time_rounded,
                                                                      color: AppColors
                                                                          .textGreyColor,
                                                                      size: height *
                                                                          0.027),
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.005,
                                                                  ),
                                                                  Text(
                                                                    formattedTime,
                                                                    style:
                                                                        blackMedium14TextStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : const Center(child: Text("No Time Table Data"))
                                  .paddingOnly(top: height * 0.3);
                        } else {
                          return const Center(
                                  child: Text("Something Went Wrong"))
                              .paddingOnly(top: height * 0.3);
                        }
                      },
                    ),
                ],
              ),
            ),
          ));
    });
  }

  Future<void> buildShowModalBottomSheet(
      BuildContext context, double height, double width) {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayBorderRadius: BorderRadius.circular(8),
      gapBetweenCalendarAndButtons: 0,
      nextMonthIcon: Container(
        height: 71,
        width: 71,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
        ),
      ),
      lastMonthIcon: Container(
        height: 71,
        width: 71,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
          ),
        ),
      ),
      buttonPadding: EdgeInsets.zero,
      okButton: Column(
        children: [
          Container(
            width: 298,
            margin: const EdgeInsets.symmetric(horizontal: 22),
            height: 48,
            decoration: BoxDecoration(
                color: const Color(0xffB70013),
                borderRadius: BorderRadius.circular(7)),
            child: const Center(
              child: Text(
                "Submit",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 45),
          Container(
            height: 4,
            width: 140,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 3,
          ),
        ],
      ),
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      cancelButton: const SizedBox(),
      dayTextStyle:
          const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: Colors.red[800],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle:
          const TextStyle(color: Color(0xffB70013), fontWeight: FontWeight.w700)
              .copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle =
              TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = TextStyle(
            color: Colors.red[400],
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
          );
        }
        return textStyle;
      },
    );
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
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                AppStrings.byRoute,
                                style: blackMedium14TextStyle.copyWith(
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: height * 0.035,
                                width: width * 0.12,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CupertinoSwitch(
                                    activeColor: AppColors.iconBlueColor,
                                    thumbColor: AppColors.whiteColor,
                                    trackColor: AppColors.iconBlueColor,
                                    value: isSwitch1,
                                    onChanged: (_) {
                                      setState(() {
                                        isSwitch1 = !isSwitch1;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                AppStrings.byRoute,
                                style: blackMedium14TextStyle.copyWith(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CalendarDatePicker2(
                            config: config,
                            value: selectedDate,
                            onValueChanged: (dates) {
                              if (dates.isNotEmpty) {
                                setState(() {
                                  selectedDate = dates;
                                });
                              }
                            },
                          ),
                          CommonButton(
                              onTap: () async {
                                log("settingController.selectedRouteId1--------------> ${settingController.selectedRouteId}");

                                if (settingController
                                    .busTimeTableData.isEmpty) {
                                  log('is empty----');

                                  bool isMatch = false;
                                  String id = "";
                                  settingController.searchDataResults1
                                      .forEach((element) {
                                    if ((element.routeNo ==
                                            settingController
                                                .selectedRouteNo) &&
                                        (element.direction.toString() ==
                                            (settingController.isForward
                                                ? "0"
                                                : "1"))) {
                                      isMatch = true;
                                      id = element.id!;
                                    }
                                  });
                                  if (isMatch == true) {
                                    await settingController.createTimeTable(
                                        body: {
                                          "route": id,
                                          "status": true
                                        }).then((value) async {
                                      settingController.busTimeTableData
                                          .clear();
                                      await settingController
                                          .busTimeTableViewModel(
                                        routeId: settingController
                                            .searchDataResults
                                            .where((element) =>
                                                element.id ==
                                                settingController
                                                    .selectedRouteId)
                                            .first
                                            .routeNo
                                            .toString()
                                            .replaceAll(" ", "%20"),
                                        direction: settingController.isForward
                                            ? "0"
                                            : "1",
                                      );
                                      await settingController
                                          .createBusDaySlotViewModel(
                                        body: {
                                          "timetable":
                                              "${settingController.busTimeTableData.first.id}",
                                          "day": DateFormat("EEEE")
                                              .format(selectedDate.first!),
                                          "status": false
                                        },
                                      );
                                      if (settingController
                                          .busTimeTableData.isNotEmpty) {
                                        bool? value = settingController
                                            .busTimeTableData.first.daySlot
                                            ?.any(
                                          (element) =>
                                              element.day
                                                  .toString()
                                                  .toLowerCase() ==
                                              DateFormat("EEEE")
                                                  .format(selectedDate.first!)
                                                  .toString()
                                                  .toLowerCase(),
                                        );

                                        if (value == true) {
                                          commonSnackBar(
                                              "Selected Day already exist. Please try with another one.");
                                          return;
                                        }
                                      }

                                      Navigator.pop(context);

                                      settingController.busTimeTableData
                                          .clear();
                                      await settingController
                                          .busTimeTableViewModel(
                                        routeId: settingController
                                            .searchDataResults
                                            .where((element) =>
                                                element.id ==
                                                settingController
                                                    .selectedRouteId)
                                            .first
                                            .routeNo
                                            .toString()
                                            .replaceAll(" ", "%20"),
                                        direction: settingController.isForward
                                            ? "0"
                                            : "1",
                                      );
                                    });
                                  } else {
                                    commonSnackBar("Route direction not found");
                                  }
                                } else {
                                  log('not empty----');
                                  await settingController
                                      .createBusDaySlotViewModel(
                                    body: {
                                      "timetable":
                                          "${settingController.busTimeTableData.first.id}",
                                      "day": DateFormat("EEEE")
                                          .format(selectedDate.first!),
                                      "status": false
                                    },
                                  );
                                  if (settingController
                                      .busTimeTableData.isNotEmpty) {
                                    bool? value = settingController
                                        .busTimeTableData.first.daySlot
                                        ?.any(
                                      (element) =>
                                          element.day
                                              .toString()
                                              .toLowerCase() ==
                                          DateFormat("EEEE")
                                              .format(selectedDate.first!)
                                              .toString()
                                              .toLowerCase(),
                                    );

                                    if (value == true) {
                                      commonSnackBar(
                                          "Selected Day already exist. Please try with another one.");
                                      return;
                                    }
                                  }

                                  Navigator.pop(context);

                                  settingController.busTimeTableData.clear();
                                  await settingController.busTimeTableViewModel(
                                    routeId: settingController.searchDataResults
                                        .where((element) =>
                                            element.id ==
                                            settingController.selectedRouteId)
                                        .first
                                        .routeNo
                                        .toString()
                                        .replaceAll(" ", "%20"),
                                    direction:
                                        settingController.isForward ? "0" : "1",
                                  );
                                }
                              },
                              title: AppStrings.submit),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  // TimePickerThemeData _myTimePickerTheme(TimePickerThemeData base) {
  //   Color myTimePickerMaterialStateColorFunc(Set<MaterialState> states,
  //       {bool withBackgroundColor = false}) {
  //     const Set<MaterialState> interactiveStates = <MaterialState>{
  //       MaterialState.pressed,
  //       MaterialState.hovered,
  //       MaterialState.focused,
  //       MaterialState.selected, //This is the one actually used
  //     };
  //     if (states.any(interactiveStates.contains)) {
  //       // the color to return when button is in pressed, hovered, focused, or selected state
  //       return Colors.red.withOpacity(0.12);
  //     }
  //     // the color to return when button is in it's normal/unfocused state
  //     return Colors.red.withOpacity(0.12);
  //   }
  //
  //   return base.copyWith(
  //     hourMinuteTextColor: Colors.red,
  //     hourMinuteColor: MaterialStateColor.resolveWith(
  //         (Set<MaterialState> states) => myTimePickerMaterialStateColorFunc(
  //             states,
  //             withBackgroundColor: true)), //Background of Hours/Minute input
  //     dayPeriodTextColor: Colors.red,
  //     dayPeriodColor: MaterialStateColor.resolveWith(
  //         myTimePickerMaterialStateColorFunc), //Background of AM/PM.
  //     dialHandColor: Colors.red,
  //   );
  // }

  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme:
                  const ColorScheme.light(primary: AppColors.primaryColor)),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );
    log("time ---->>>$time");
    return time;
  }
}
