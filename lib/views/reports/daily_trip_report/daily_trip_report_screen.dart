import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
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
                commonBorderButton(title: AppStrings.selectRoute, onTap: () {}),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
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
                                      controller.changeIsForward();
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: h * 0.06,
                                  width: w * 0.3,
                                  margin:
                                      EdgeInsets.symmetric(vertical: h * 0.013),
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
                                        width: w * 0.02,
                                      ),
                                      SvgPicture.asset(
                                        AppImages.time,
                                        color: AppColors.textGreyColor,
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      Text(
                                        "05.15 PM",
                                        style: greyMedium14TextStyle.copyWith(
                                          color: const Color(0xff333333),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: w * 0.07,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListView.builder(
                              itemCount: 6,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: index == 4
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: w * 0.05),
                                              child: const Dash(
                                                  direction: Axis.vertical,
                                                  length: 70,
                                                  dashLength: 10,
                                                  dashColor:
                                                      AppColors.lightGreyColor,
                                                  dashGap: 6),
                                            )
                                          : Padding(
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
                                                                    index == 5
                                                                        ? "Stop-N"
                                                                        : "Stop-1",
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
                                                                "14.00",
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
                                                                "14.10",
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
                          )
                        ],
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
