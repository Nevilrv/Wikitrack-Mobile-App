import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppStrings.dart';

class DailyTripManagement extends StatefulWidget {
  const DailyTripManagement({super.key});

  @override
  State<DailyTripManagement> createState() => _DailyTripManagementState();
}

class _DailyTripManagementState extends State<DailyTripManagement> {
  bool isSwitch = false;
  String dropdownValue = 'KA03 EH 6766';

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      appBar: commonSubTitleAppBar(
        title: AppStrings.dailyTripManagement,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.075),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.07,
                width: width,
                margin:
                    EdgeInsets.only(top: height * 0.05, bottom: height * 0.035),
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.routes,
                      style: textGreyMedium16TextStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          "314.0",
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
                  ],
                ),
              ),
              Container(
                height: height * 0.07,
                width: width,
                margin: EdgeInsets.only(bottom: height * 0.05),
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.date,
                      style: textGreyMedium16TextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog<DateTime>(
                          context: context,
                          builder: (BuildContext context) {
                            return Theme(
                              data: ThemeData(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors.primaryColor,
                                  onPrimary: Colors.white,
                                  surface: AppColors.whiteColor,
                                  onSurface: AppColors.primaryColor,
                                ),
                              ),
                              child: DatePickerDialog(
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now(),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'DD-MM-YYYY (Sunday)',
                        style: textGreyMedium16TextStyle.copyWith(
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                5,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height * 0.06,
                      width: width * 0.3,
                      margin: EdgeInsets.symmetric(vertical: height * 0.013),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.02,
                          ),
                          SvgPicture.asset(
                            AppImages.time,
                            color: AppColors.textGreyColor,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            '05.15 PM',
                            style: greyMedium14TextStyle.copyWith(
                              color: const Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.06,
                      width: width * 0.48,
                      margin: EdgeInsets.symmetric(vertical: height * 0.013),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.02,
                          ),
                          SvgPicture.asset(
                            AppImages.routeManage,
                            color: AppColors.textGreyColor,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          index == 4
                              ? SizedBox(
                                  width: width * 0.35,
                                  child: DropdownButton<String>(
                                    underline: const SizedBox(),
                                    value: dropdownValue,
                                    // elevation: 16,
                                    isExpanded: true,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'KA03 EH 6766',
                                      'KA03 EH 6767',
                                      'KA03 EH 6768',
                                      'KA03 EH 6769',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : Text(
                                  'KA03 EH 6766',
                                  style: greyMedium14TextStyle.copyWith(
                                    color: const Color(0xff333333),
                                  ),
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
      ),
    );
  }
}
