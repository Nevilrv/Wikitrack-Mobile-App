import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/response_model/dailytripregister_response_model.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppDialog.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/settings/controller/setting_controller.dart';

import '../../../response_model/get_vehicle_list_res_model.dart';

class DailyTripManagement extends StatefulWidget {
  const DailyTripManagement({super.key});

  @override
  State<DailyTripManagement> createState() => _DailyTripManagementState();
}

class _DailyTripManagementState extends State<DailyTripManagement> {
  Map<String, dynamic> dropdownData = {};

  Result? dropdownValue;
  SettingController settingController = Get.find();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await settingController.getRouteListViewModel();
    await settingController.getVehicleListViewModel();

    // await settingController.dailyTripRegisterViewModel();
  }

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
      body: GetBuilder<SettingController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.075),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                CommonButton(
                    onTap: () async {
                      controller.searchResult("");
                      controller.searchController.clear();

                      AppDialog().selectRouteDialog(
                        controller: controller,
                        context,
                        isTrip: true,
                        from: 'daily_trip_management',
                        title: AppStrings.selectRoute,
                      );
                    },
                    title: AppStrings.selectRoute),
                if (controller.selectedRouteId != null)
                  Container(
                    height: height * 0.07,
                    width: width,
                    margin: EdgeInsets.only(
                        top: height * 0.03, bottom: height * 0.035),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              height: height * 0.04,
                              width: width * 0.13,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: CupertinoSwitch(
                                  activeColor: AppColors.iconBlueColor,
                                  thumbColor: AppColors.whiteColor,
                                  trackColor: AppColors.iconBlueColor,
                                  value: controller.isForward,
                                  onChanged: (value) async {
                                    await controller.changeIsForward();

                                    if (controller.selectedDate != null) {
                                      controller.data.clear();
                                      await controller
                                          .dailyTripManagementViewModel(
                                        routeId: controller.searchDataResults
                                            .where((element) =>
                                                element.id ==
                                                controller.selectedRouteId)
                                            .first
                                            .routeNo
                                            .toString()
                                            .replaceAll(" ", "%20"),
                                        direction:
                                            controller.isForward ? "0" : "1",
                                        day: DateFormat("EEEE")
                                            .format(controller.selectedDate!),
                                      );
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
                      ],
                    ),
                  ),
                if (controller.selectedRouteId != null)
                  GestureDetector(
                    onTap: () async {
                      await controller.selectDate(context);
                      setState(() {});

                      if (controller.selectedDate != null) {
                        controller.data.clear();
                        await controller.dailyTripManagementViewModel(
                          routeId: controller.searchDataResults
                              .where((element) =>
                                  element.id == controller.selectedRouteId)
                              .first
                              .routeNo
                              .toString()
                              .replaceAll(" ", "%20"),
                          direction: controller.isForward ? "0" : "1",
                          day: DateFormat("EEEE")
                              .format(controller.selectedDate!),
                        );
                      }
                    },
                    child: Container(
                      height: height * 0.07,
                      width: width,
                      margin: EdgeInsets.only(bottom: height * 0.025),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.primaryColor, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.date,
                            style: textGreyMedium16TextStyle,
                          ),
                          Builder(
                            builder: (context) {
                              return controller.selectedDate != null
                                  ? Text(
                                      "${DateFormat("dd/MM/yyyy").format(controller.selectedDate!)} (${DateFormat("EEEE").format(controller.selectedDate)})",
                                      style: textGreyMedium16TextStyle.copyWith(
                                        color: const Color(0xff333333),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Text(
                                      "Select Date",
                                      style: textGreyMedium16TextStyle.copyWith(
                                          color: const Color(0xff333333),
                                          fontWeight: FontWeight.w500),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                Builder(
                  builder: (context) {
                    if (controller.dailyTripManagementResponse.status ==
                        Status.LOADING) {
                      return const Center(child: CircularProgressIndicator())
                          .paddingOnly(top: height * 0.2);
                    } else if (controller.dailyTripManagementResponse.status ==
                        Status.ERROR) {
                      return const Center(child: Text("Something Went Wrong"));
                    } else if (controller.dailyTripManagementResponse.status ==
                        Status.COMPLETE) {
                      return controller.data.isEmpty
                          ? Center(
                              child: const Text('No Daily Trip Data')
                                  .paddingOnly(top: height * 0.2),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller
                                  .data[0]
                                  .daySlot?[controller.data[0].daySlot!
                                      .indexWhere((element) =>
                                          element.day ==
                                          DateFormat("EEEE")
                                              .format(controller.selectedDate))]
                                  .timeSlot
                                  ?.length,
                              itemBuilder: (context, index) {
                                var data = controller
                                    .data[0]
                                    .daySlot![controller.data[0].daySlot!
                                        .indexWhere((element) =>
                                            element.day ==
                                            DateFormat("EEEE").format(
                                                controller.selectedDate))]
                                    .timeSlot?[index];

                                DateTime time = DateFormat("HH:mm")
                                    .parse(data!.time.toString());
                                String formattedTime =
                                    DateFormat("HH:mm").format(time);

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: height * 0.06,
                                      width: width * 0.3,
                                      margin: EdgeInsets.symmetric(
                                          vertical: height * 0.013),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
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
                                            formattedTime,
                                            style:
                                                greyMedium14TextStyle.copyWith(
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.06,
                                      width: width * 0.48,
                                      margin: EdgeInsets.symmetric(
                                          vertical: height * 0.013),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
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
                                            width: width * 0.02,
                                          ),
                                          SvgPicture.asset(
                                            AppImages.routeManage,
                                            color: AppColors.textGreyColor,
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Builder(builder: (context) {
                                            return data
                                                    .dailyrouteTimeslot!.isEmpty
                                                ? SizedBox(
                                                    width: width * 0.35,
                                                    child:
                                                        DropdownButton<Result>(
                                                      underline:
                                                          const SizedBox(),
                                                      hint: Text(
                                                        dropdownData["index"] ==
                                                                index
                                                            ? dropdownData[
                                                                "value"]
                                                            : "Select",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      isExpanded: true,
                                                      onChanged: (Result?
                                                          newValue) async {
                                                        setState(() {
                                                          dropdownValue =
                                                              newValue!;

                                                          dropdownData.addAll({
                                                            "index": index,
                                                            "value":
                                                                dropdownValue
                                                                    ?.regNo
                                                          });
                                                        });

                                                        Map<String, dynamic>
                                                            body = {
                                                          "timeslot":
                                                              "${data.id}",
                                                          "vehicle":
                                                              "${dropdownValue?.id}",
                                                          "date": DateFormat(
                                                                  "yyyy-MM-dd")
                                                              .format(DateTime
                                                                  .now()),
                                                          "status": true,
                                                        };
                                                        await controller
                                                            .createTimeSlotViewModel(
                                                                body: body);

                                                        await controller
                                                            .dailyTripManagementViewModel(
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
                                                          direction: controller
                                                                  .isForward
                                                              ? "0"
                                                              : "1",
                                                          day: DateFormat(
                                                                  "EEEE")
                                                              .format(controller
                                                                  .selectedDate),
                                                        );
                                                      },
                                                      items: controller
                                                          .busRegister
                                                          .map<
                                                              DropdownMenuItem<
                                                                  Result>>((Result
                                                              value) {
                                                        return DropdownMenuItem<
                                                            Result>(
                                                          value: value,
                                                          child: Text(
                                                              "${value.regNo}"),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: width * 0.3,
                                                    child: Text(
                                                      '${data.dailyrouteTimeslot?[0].vehicle?.regNo}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          greyMedium14TextStyle
                                                              .copyWith(
                                                        color: const Color(
                                                            0xff333333),
                                                      ),
                                                    ),
                                                  );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
