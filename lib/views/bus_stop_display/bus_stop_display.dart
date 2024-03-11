import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/bus_stop_display/controller/bus_stop_display_controller.dart';

import '../../common/commontextfield.dart';

class BusStopDisplayScreen extends StatefulWidget {
  const BusStopDisplayScreen({super.key});

  @override
  State<BusStopDisplayScreen> createState() => _BusStopDisplayScreenState();
}

class _BusStopDisplayScreenState extends State<BusStopDisplayScreen> {
  BusStopDisplayController busStopDisplayController = Get.find();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await busStopDisplayController.getStopListViewModel();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonSubTitleAppBar(
        title: AppStrings.busStopDisplay,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<BusStopDisplayController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.02,
                  ),
                  commonBorderButton(
                      onTap: () {
                        controller.tempStopResult.clear();
                        controller.tempStopResult.addAll(controller.stopResult);
                        controller.update();
                        TextEditingController searchController = TextEditingController();
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
                                    AppStrings.selectStop,
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
                                                controller.searchResult(p0, setState123);
                                              },
                                              controller: searchController,
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
                                                itemCount: controller.tempStopResult.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    onTap: () {
                                                      controller.getRouteList(controller.tempStopResult[index].stopNo);
                                                      // Get.back();
                                                    },
                                                    title: Builder(
                                                      builder: (context) {
                                                        return Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                (controller.tempStopResult[index].name
                                                                            .toString()
                                                                            .isEmpty
                                                                        ? "NA"
                                                                        : controller.tempStopResult[index].name)
                                                                    .toString()
                                                                    .capitalizeFirst
                                                                    .toString(),
                                                              ),
                                                            ),
                                                            const SizedBox(width: 5),
                                                            // Container(
                                                            //   height: 17,
                                                            //   width: 17,
                                                            //   padding: const EdgeInsets.all(2),
                                                            //   decoration: BoxDecoration(
                                                            //     shape: BoxShape.circle,
                                                            //     border: Border.all(
                                                            //       color: controller.searchDataResults[index].routeNo
                                                            //                   .toString() ==
                                                            //               controller.selectedRouteId.toString()
                                                            //           ? AppColors.primaryColor
                                                            //           : AppColors.textGreyColor,
                                                            //       width: 2,
                                                            //     ),
                                                            //   ),
                                                            //   child: Center(
                                                            //     child: Container(
                                                            //       height: 17,
                                                            //       width: 17,
                                                            //       decoration: BoxDecoration(
                                                            //         shape: BoxShape.circle,
                                                            //         color: controller.searchDataResults[index].routeNo
                                                            //                     .toString() ==
                                                            //                 controller.selectedRouteId.toString()
                                                            //             ? AppColors.primaryColor
                                                            //             : Colors.transparent,
                                                            //       ),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
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
                      title: AppStrings.selectStop),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  commonBorderButton(
                    height: h * 0.055,
                    onTap: () {},
                    title: AppStrings.selectStop,
                    child: Row(
                      children: [
                        SizedBox(
                          width: w * 0.03,
                        ),
                        Text(
                          AppStrings.route,
                          style: blackMedium14TextStyle,
                        ),
                        Spacer(),
                        Text(
                          "Time (S)",
                          style: blackMedium14TextStyle,
                        ),
                        SizedBox(
                          width: w * 0.03,
                        ),
                      ],
                    ),
                    color: AppColors.lightGreyColor,
                    borderColor: Colors.transparent,
                  ),
                  controller.isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ))
                      : controller.routeList.isEmpty
                          ? Text(
                              'No data found',
                              style: blackMedium14TextStyle,
                            )
                          : ListView.builder(
                              itemCount: controller.routeList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          spreadRadius: 0.01,
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        )
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: h * 0.012),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
                                          Text(
                                            controller.routeList[index].routeNo! ?? "N/A",
                                            style: blackMedium14TextStyle,
                                          ),
                                          SizedBox(
                                            width: w * 0.03,
                                          ),
                                          Text(
                                            controller.routeList[index].name!,
                                            style: blackMedium14TextStyle,
                                          ),
                                          Spacer(),
                                          Text(
                                            controller.times[index],
                                            style: blackMedium14TextStyle,
                                          ),
                                          SizedBox(
                                            width: w * 0.018,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
