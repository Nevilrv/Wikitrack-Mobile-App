import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/commonDialogue.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';

class RouteManagement extends StatefulWidget {
  const RouteManagement({Key? key}) : super(key: key);

  @override
  State<RouteManagement> createState() => _RouteManagementState();
}

class _RouteManagementState extends State<RouteManagement> {
  TextEditingController routeId = TextEditingController();
  TextEditingController stop = TextEditingController();
  TextEditingController travelTime = TextEditingController();
  TextEditingController stopDevice = TextEditingController();
  TextEditingController stopNo = TextEditingController();
  TextEditingController stopName = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController lang = TextEditingController();
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
      floatingActionButton: GestureDetector(
        onTap: () {
          addNewRouteBottomSheet(context, height, width);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            CommonButton(
                onTap: () {
                  showDataAlert(
                    context,
                    text: AppStrings.selectRoute,
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
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Center(child: Text('233.0')),
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
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Center(child: Text('233.0')),
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
                Expanded(
                  child: Column(
                    children: List.generate(
                        1,
                        (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Text(
                                      "${AppStrings.stop} - ${index + 1}",
                                      style: blackMedium16TextStyle,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.03),
                                  child: Dash(
                                      direction: Axis.vertical,
                                      length: 50,
                                      dashLength: 8,
                                      dashColor: AppColors.textGreyColor,
                                      dashGap: 4),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    addStopBottomSheet(context, height, width);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
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
                            )),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: List.generate(
                        1,
                        (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Text(
                                      "${AppStrings.stop} - ${index + 1}",
                                      style: blackMedium16TextStyle,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.03),
                                  child: Dash(
                                      direction: Axis.vertical,
                                      length: 50,
                                      dashLength: 8,
                                      dashColor: AppColors.textGreyColor,
                                      dashGap: 4),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    addStopBottomSheet(context, height, width);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
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
                            )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> addStopBottomSheet(
      BuildContext context, double height, double width) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: IntrinsicHeight(
              // height: height * 0.7,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                color: AppColors.grey2Color.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(100)),
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
                          controller: stop,
                          validator: (p0) {},
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
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                                addNewRouteBottomSheet1(context, height, width);
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
                          controller: travelTime,
                          validator: (p0) {},
                        ),
                        SizedBox(
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
                          controller: stopDevice,
                          validator: (p0) {},
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
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
        });
  }

  void addNewRouteBottomSheet1(
      BuildContext context, double height, double width) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: IntrinsicHeight(
              // height: height * 0.65,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                color: AppColors.grey2Color.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(100)),
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
                          AppStrings.stopno,
                          style: grey1Medium12TextStyle,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        commonTextField(
                          controller: stopNo,
                          validator: (p0) {},
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
                          controller: stopName,
                          validator: (p0) {},
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.lat,
                                    style: grey1Medium12TextStyle,
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  commonTextField(
                                    controller: lat,
                                    validator: (p0) {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.07,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.lang,
                                    style: grey1Medium12TextStyle,
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  commonTextField(
                                    controller: lang,
                                    validator: (p0) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
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
        });
  }

  Future<void> addNewRouteBottomSheet(
      BuildContext context, double height, double width) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: IntrinsicHeight(
              // height: height * 0.4,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          AppStrings.routeId,
                          style: grey1Medium12TextStyle,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        commonTextField(
                          controller: routeId,
                          validator: (p0) {},
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
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
        });
  }
}
