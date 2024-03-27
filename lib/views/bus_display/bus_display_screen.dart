import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/bus_display/controller/bus_display_controller.dart';

class BusDisplayScreen extends StatefulWidget {
  const BusDisplayScreen({super.key});

  @override
  State<BusDisplayScreen> createState() => _BusDisplayScreenState();
}

class _BusDisplayScreenState extends State<BusDisplayScreen> {
  BusDisplayController busDisplayController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await busDisplayController.getVehicleListViewModel();
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
        title: AppStrings.busDisplay,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<BusDisplayController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.015,
                ),
                commonBorderButton(
                    onTap: () {
                      controller.searchId = "";
                      controller.selector = 0;
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
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              commonTextField(
                                                controller: search,
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                textColor: AppColors.blackColor,
                                                color: AppColors.iconGreyColor,
                                                onChanged: (value) {
                                                  controller
                                                      .searchStopResult(value);
                                                  setState1(() {});
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                child: ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const Divider(
                                                        height: 0);
                                                  },
                                                  itemCount: controller
                                                      .searchData.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      onTap: () async {
                                                        controller.searchId =
                                                            controller
                                                                    .searchData[
                                                                        index]
                                                                    .regNo ??
                                                                '';

                                                        controller.selector = controller
                                                            .searchData
                                                            .indexWhere((element) =>
                                                                element.id ==
                                                                controller
                                                                    .searchData[
                                                                        index]
                                                                    .id);
                                                        controller.loading3 =
                                                            false;
                                                        setState(() {});
                                                        await controller
                                                            .getStopTimeByRouteNo(
                                                                routeNo:
                                                                    controller
                                                                        .searchId,
                                                                setter:
                                                                    setState1);
                                                      },
                                                      title: Text(controller
                                                              .searchData[index]
                                                              .regNo ??
                                                          ''),
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
                                                    child:
                                                        CircularProgressIndicator(
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
                    },
                    title: AppStrings.selectVehicle),
                SizedBox(
                  height: h * 0.015,
                ),
                controller.nextStop == ""
                    ? Text(
                        "No Data Found",
                        style: blackMedium14TextStyle,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.routeManage,
                                  height: h * 0.03, width: w * 0.03),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Text(
                                "Route - ${controller.lastStop} to ${controller.nextStop}",
                                style: blackMedium14TextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.time,
                                height: h * 0.03,
                                width: w * 0.03,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Text(
                                "Start Time - ${controller.nextStopTime}",
                                style: blackMedium14TextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.03,
                          ),
                          commonBorderButton(
                            height: h * 0.055,
                            onTap: () {},
                            child: Row(
                              children: [
                                SizedBox(
                                  width: w * 0.03,
                                ),
                                Text(
                                  AppStrings.nextStop,
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
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 0.01,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  Text(
                                    "${controller.nextStop}",
                                    style: blackMedium14TextStyle,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${controller.nextStopTime}",
                                    style: blackMedium14TextStyle,
                                  ),
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
