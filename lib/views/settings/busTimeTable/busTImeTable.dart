import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/commonDialogue.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/utils/extension.dart';

class BusTimeTable extends StatefulWidget {
  const BusTimeTable({super.key});

  @override
  State<BusTimeTable> createState() => _RountineTripManagementState();
}

class _RountineTripManagementState extends State<BusTimeTable> {
  List gridList = [
    "05.15 PM",
    "05.30 PM",
    "05.45 PM",
    "06.00 PM",
    "06.15 PM",
    "06.30 PM",
  ];
  bool isSwitch = false;
  bool isSwitch1 = false;
  List<DateTime?> dialogCalendarPickerValue = [
    DateTime(2024, 1, 1),
    DateTime(2024, 1, 13),
  ];

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: commonSubTitleAppBar(
        title: AppStrings.routineTripManage,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          buildShowModalBottomSheet(context, height, width);
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
      ),
      body: SingleChildScrollView(
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
                    showDataAlert(
                      context,
                      text: AppStrings.selectRoute,
                    );
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              // 24.0.addHSpace(),
              Row(
                children: [
                  Text(
                    "314.0",
                    style: blackMedium16TextStyle.copyWith(
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: height * 0.04,
                    width: width * 0.13,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CupertinoSwitch(
                        activeColor: AppColors.iconBlueColor,
                        // color of the round icon, which moves from right to left
                        thumbColor: AppColors.whiteColor,
                        // when the switch is off
                        trackColor: AppColors.iconBlueColor,
                        value: isSwitch,
                        onChanged: (_) {
                          setState(() {
                            isSwitch = !isSwitch;
                          });
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
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: commonBorderButton(
                          borderColor: AppColors.lightGreyColor,
                          color: AppColors.lightGreyColor,
                          title: AppStrings.sunday,
                          textColor: AppColors.blackColor,
                          onTap: () {})),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // _myTimePickerTheme(ThemeData().timePickerTheme);
                        getTime(context: context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor)),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisExtent: height * 0.065),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2))
                            ],
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time_rounded,
                                  color: AppColors.textGreyColor,
                                  size: height * 0.027),
                              SizedBox(
                                width: width * 0.005,
                              ),
                              Text(
                                gridList[index],
                                style: blackMedium14TextStyle,
                              ),
                            ],
                          )),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: commonBorderButton(
                          borderColor: AppColors.lightGreyColor,
                          // color: AppColors.lightGreyColor,
                          title: "MONDAY",
                          textColor: AppColors.blackColor,
                          onTap: () {})),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryColor)),
                      child: Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: commonBorderButton(
                          borderColor: AppColors.lightGreyColor,
                          // color: AppColors.lightGreyColor,
                          title: "TUESDAY",
                          textColor: AppColors.blackColor,
                          onTap: () {})),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryColor)),
                      child: Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: commonBorderButton(
                          borderColor: AppColors.lightGreyColor,
                          // color: AppColors.lightGreyColor,
                          title: "SATURDAY",
                          textColor: AppColors.blackColor,
                          onTap: () {})),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryColor)),
                      child: Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
      calendarType: CalendarDatePicker2Type.range,
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
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: height * 0.01,
                                width: width * 0.09,
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.grey2Color.withOpacity(0.5),
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
                                Container(
                                  height: height * 0.035,
                                  width: width * 0.12,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: CupertinoSwitch(
                                      activeColor: AppColors.iconBlueColor,
                                      // color of the round icon, which moves from right to left
                                      thumbColor: AppColors.whiteColor,
                                      // when the switch is off
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
                              value: dialogCalendarPickerValue,
                              onValueChanged: (dates) {
                                if (dates.isNotEmpty) {
                                  setState(() {
                                    dialogCalendarPickerValue = dates;
                                  });
                                }
                              },
                            ),
                            // SizedBox(
                            //   height: height * 0.03,
                            // ),
                            CommonButton(
                                onTap: () {
                                  Get.back();
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
