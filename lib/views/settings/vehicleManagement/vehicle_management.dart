import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/settings/controller/setting_controller.dart';
import '../../../common/commontextfield.dart';

class VehicleManagement extends StatefulWidget {
  const VehicleManagement({super.key});

  @override
  State<VehicleManagement> createState() => _VehicleManagementState();
}

class _VehicleManagementState extends State<VehicleManagement> {
  final PageController _pageController1 = PageController();
  List images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo1kplxuW3G9gRB4FmZCrRSQX4L4eGgGCehg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSn6Z_UAIXa3CAnmwBlxhQc_oLu1yfL76HKQTGFLdwBNlZR8mLaYyEXQHHGkprKTinZNsA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI8c-zCsoeYWWPfAamYIrRx3lE8GDgYFMyR_ukS3z3QElmw252JvP_0b09TqGt8A3neeQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0dE2Y6IuhgiZbxc7oUhwrhD3qfJRMwoBXYsTZACBFlkjB-QMdvCunJeRvlCmPEA5YIgw&usqp=CAU',
  ];

  int selector = 0;
  SettingController settingController = Get.find();

  @override
  void initState() {
    super.initState();
    settingController.getVehicleListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;

    return Scaffold(
      appBar: commonSubTitleAppBar(
        title: AppStrings.vehicleManagement,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          settingController.clearController();
          addNewVehicleBottomSheet(context, height, width);
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
      body: GetBuilder<SettingController>(builder: (controller) {
        if (controller.getVehicleListResponse.status == Status.LOADING) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (controller.getVehicleListResponse.status == Status.ERROR) {
          return const Text('Something Went Wrong');
        } else if (controller.getVehicleListResponse.status == Status.COMPLETE) {
          // GetVehiclesListResModel response =
          //     controller.getVehicleListResponse.data;
          return controller.allData.isEmpty
              ? const Center(child: Text('No vehicle data'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CommonButton(
                            title: AppStrings.selectVehicle,
                            onTap: () {
                              showDataAlertVehicle(context, text: AppStrings.selectVehicle, controller: controller);
                            }),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: AppColors.iconGreyColor),
                        //             shape: BoxShape.circle),
                        //         child: const Center(
                        //           child: Padding(
                        //             padding: EdgeInsets.all(2.0),
                        //             child: Icon(
                        //               Icons.arrow_back_ios_rounded,
                        //               size: 12,
                        //               color: AppColors.iconGreyColor,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       height: height * 0.3,
                        //       width: width * 0.7,
                        //       decoration: BoxDecoration(
                        //           color: AppColors.lightGreyColor,
                        //           borderRadius: BorderRadius.circular(20)),
                        //       child: CarouselSlider.builder(
                        //         options: CarouselOptions(
                        //           height: height * 0.3,
                        //           viewportFraction: 1,
                        //           padEnds: true,
                        //           initialPage: images.length,
                        //           enableInfiniteScroll: false,
                        //           enlargeCenterPage: true,
                        //           enlargeFactor: 0.3,
                        //           reverse: false,
                        //           scrollDirection: Axis.horizontal,
                        //         ),
                        //         itemCount: images.length,
                        //         itemBuilder:
                        //             (BuildContext context, int index, int realIndex) {
                        //           return Builder(
                        //             builder: (BuildContext context) {
                        //               log('index::::::::::::::::::::==========>>>>>>>>>>>${index}');
                        //
                        //               return ClipRRect(
                        //                 borderRadius: BorderRadius.circular(20),
                        //                 child: Image.network(
                        //                   images[index],
                        //                   fit: BoxFit.cover,
                        //                 ),
                        //               );
                        //             },
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: AppColors.iconGreyColor),
                        //             shape: BoxShape.circle),
                        //         child: const Center(
                        //           child: Padding(
                        //             padding: EdgeInsets.all(2.0),
                        //             child: Icon(
                        //               Icons.arrow_forward_ios,
                        //               size: 12,
                        //               color: AppColors.iconGreyColor,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // 40.0.addHSpace(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _pageController1.previousPage(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.iconGreyColor), shape: BoxShape.circle),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 12,
                                      color: AppColors.iconGreyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.27,
                              width: width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: PageView(
                                physics: const BouncingScrollPhysics(),
                                controller: _pageController1,
                                onPageChanged: (value) {
                                  setState(() {
                                    selector = value;
                                  });
                                },
                                children: List.generate(
                                  controller.response?.count ?? 0,
                                  (index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      controller.allData[selector].vehicleImg == null
                                          ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo1kplxuW3G9gRB4FmZCrRSQX4L4eGgGCehg&usqp=CAU'
                                          : controller.allData[selector].vehicleImg!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if ((controller.response?.count)! > selector + 1) {
                                  _pageController1.nextPage(
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.iconGreyColor), shape: BoxShape.circle),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: AppColors.iconGreyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        // commonBorderButton(title: AppStrings.chassisID),
                        commonBorderButton(title: controller.allData[selector].chassisNo ?? AppStrings.chassisID),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        commonBorderButton(title: controller.allData[selector].regNo ?? AppStrings.regNo),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            showBusDisplayList(context,
                                title: '', controller: controller, index: selector, isFrom: 'displaySection');
                          },
                          child: commonBorderButton(
                              title: controller.allData[selector].busDisplay?.imei ?? AppStrings.selectBus),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            showGpsDeviceList(context, title: '', controller: controller, isFrom: 'displaySection');
                          },
                          child: commonBorderButton(
                              title: controller.allData[selector].gpsDevice?.imei ?? AppStrings.selectGPS),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ),
                );
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  /// SHOW ALERT VEHICLE
  showDataAlertVehicle(
    context, {
    required String text,
    required SettingController controller,
  }) async {
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
              title: Text(
                text,
                style: const TextStyle(fontSize: 24.0),
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
                          controller: search,
                          prefixIcon: const Icon(Icons.search),
                          textColor: AppColors.blackColor,
                          color: AppColors.iconGreyColor,
                          onChanged: (value) {
                            controller.searchStopResult(value);
                            setState1(() {});
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(height: 0);
                            },
                            itemCount: controller.searchData.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  controller.searchId = controller.searchData[index].id ?? '';

                                  selector = controller.searchData
                                      .indexWhere((element) => element.id == controller.searchData[index].id);

                                  setState(() {});
                                  Get.back();
                                },
                                title: Text(controller.searchData[index].regNo ?? ''),
                              );
                            },
                          ),
                        ),
                        // CommonButton(title: AppStrings.add)
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
  }

  /// SHOW BUS DISPLAY
  // showBusDisplayList(
  //   context, {
  //   required String text,
  //   required SettingController controller,
  // }) async {
  //   await controller.getBusDisplayViewModel();
  //   TextEditingController search = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(builder: (context, setState1) {
  //         return AlertDialog(
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(
  //                 20.0,
  //               ),
  //             ),
  //           ),
  //           contentPadding: const EdgeInsets.only(
  //             top: 10.0,
  //           ),
  //           // title: Text(
  //           //   text,
  //           //   style: const TextStyle(fontSize: 24.0),
  //           // ),
  //           content: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //             child: SingleChildScrollView(
  //               child: SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.5,
  //                 width: MediaQuery.of(context).size.width * 0.9,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     commonTextField(
  //                       controller: search,
  //                       prefixIcon: const Icon(Icons.search),
  //                       onChanged: (value) {
  //                         controller.searchBusDisplayResult(value);
  //                         setState1(() {});
  //                       },
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Expanded(
  //                       child: ListView.builder(
  //                         itemCount: controller.busResult.length,
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           return Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(controller.busResult[index].imei),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                     CommonButton(title: AppStrings.add)
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }

  showBusDisplayList(
    context, {
    String? title,
    int? index,
    required SettingController controller,
    required String isFrom,
  }) async {
    await controller.getBusDisplayViewModel();
    TextEditingController search = TextEditingController();
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
              contentPadding: const EdgeInsets.only(top: 0.0),
              content: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 10),
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
                            controller.searchGpsDeviceResult(p0);
                            setState123(() {});
                          },
                          controller: search,
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
                            itemCount: controller.busResult.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  if (isFrom == 'createSection') {
                                    controller.busDisplayDeviceId = controller.busResult[index].id;
                                    controller.imeiId.text = controller.busResult[index].imei;
                                    Get.back();
                                  } else {
                                    Map<String, String> body = {
                                      "id": controller.busResult[index].id,
                                      "chassis_no": controller.allData[index].chassisNo.toString(),
                                      "reg_no": controller.allData[index].regNo.toString(),
                                      "bus_display": controller.busResult[index].id,
                                      "gps_device": controller.allData[index].gpsDevice?.id ?? '',
                                      "status": 'true'
                                    };
                                    log("controller.allData[index].vehicleImg--------------> ${controller.allData[index].vehicleImg}");
                                    log("controller.allData[index].chassisNo.toString()--------------> ${controller.allData[index].chassisNo.toString()}");

                                    controller.updateVehicleRouteViewModel(
                                        body: body,
                                        uuid: controller.response?.results?[index].id ?? '',
                                        vehicleImage: controller.allData[index].vehicleImg == null
                                            ? ""
                                            : controller.allData[index].vehicleImg!);
                                    Get.back();
                                  }
                                },
                                title: Text(
                                  (controller.busResult[index].imei.toString().isEmpty
                                          ? "NA"
                                          : controller.busResult[index].imei)
                                      .toString()
                                      .capitalizeFirst
                                      .toString(),
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
  }

  /// SHOW BUS DISPLAY
  // showGpsDeviceList(
  //   context, {
  //   required String text,
  //   required SettingController controller,
  // }) async {
  //   await controller.getGPSImeiListViewModel();
  //   TextEditingController search = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(builder: (context, setState1) {
  //         return AlertDialog(
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(
  //                 20.0,
  //               ),
  //             ),
  //           ),
  //           contentPadding: const EdgeInsets.only(
  //             top: 10.0,
  //           ),
  //           // title: Text(
  //           //   text,
  //           //   style: const TextStyle(fontSize: 24.0),
  //           // ),
  //           content: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //             child: SingleChildScrollView(
  //               child: SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.5,
  //                 width: MediaQuery.of(context).size.width * 0.9,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     commonTextField(
  //                       controller: search,
  //                       prefixIcon: const Icon(Icons.search),
  //                       onChanged: (value) {
  //                         controller.searchGpsDeviceResult(value);
  //                         setState1(() {});
  //                       },
  //                     ),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     Expanded(
  //                       child: ListView.builder(
  //                         itemCount: controller.gpsDeviceResult.length,
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           return Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Column(
  //                               children: [
  //                                 const Divider(),
  //                                 Text(controller.gpsDeviceResult[index].imei),
  //                                 const Divider()
  //                               ],
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                     // CommonButton(title: AppStrings.add)
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }

  showGpsDeviceList(
    context, {
    String? title,
    required SettingController controller,
    required String isFrom,
  }) async {
    await controller.getGPSImeiListViewModel();
    TextEditingController search = TextEditingController();
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
              contentPadding: const EdgeInsets.only(top: 0.0),
              // title: Text(
              //   title.toString(),
              //   style: const TextStyle(fontSize: 24.0),
              // ),
              content: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 10),
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
                            controller.searchGpsDeviceResult(p0);
                            setState123(() {});
                          },
                          controller: search,
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
                            itemCount: controller.gpsDeviceResult.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  if (isFrom == 'createSection') {
                                    controller.gpsDeviceId = controller.gpsDeviceResult[index].id;
                                    controller.gpsId.text = controller.gpsDeviceResult[index].imei;
                                    Get.back();
                                  } else {
                                    Map<String, String> body = {
                                      "id": controller.gpsDeviceResult[index].id,
                                      "chassis_no": controller.allData[index].chassisNo.toString(),
                                      "reg_no": controller.allData[index].regNo.toString(),
                                      "bus_display": controller.allData[index].busDisplay?.id ?? "",
                                      "gps_device": controller.gpsDeviceResult[index].id,
                                      "status": 'true'
                                    };
                                    log("controller.allData[index].vehicleImg--------------> ${controller.allData[index].vehicleImg}");
                                    log("controller.allData[index].chassisNo.toString()--------------> ${controller.allData[index].chassisNo.toString()}");

                                    Get.back();
                                    controller.updateVehicleRouteViewModel(
                                        body: body,
                                        uuid: controller.response?.results?[index].id ?? '',
                                        vehicleImage: controller.allData[index].vehicleImg == null
                                            ? ""
                                            : controller.allData[index].vehicleImg!);
                                  }
                                },
                                title: Text(
                                  (controller.gpsDeviceResult[index].imei.toString().isEmpty
                                          ? "NA"
                                          : controller.gpsDeviceResult[index].imei)
                                      .toString()
                                      .capitalizeFirst
                                      .toString(),
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
  }

  Future<void> addNewVehicleBottomSheet(BuildContext context, double height, double width) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            borderSide: BorderSide.none),
        builder: (BuildContext context) {
          return GetBuilder<SettingController>(
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: IntrinsicHeight(
                    // height: height * 0.4,
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
                                    color: AppColors.grey2Color.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.05,
                                bottom: height * 0.03,
                              ),
                              child: Text(
                                AppStrings.addNewVehicle,
                                style: blackMedium16TextStyle,
                              ),
                            ),

                            /// Chasis Id
                            Text(
                              AppStrings.chassisID,
                              style: grey1Medium12TextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.02),
                              child: commonTextField(
                                controller: controller.chasisId,
                                validator: (p0) {
                                  return null;
                                },
                              ),
                            ),

                            /// Register No
                            Text(
                              AppStrings.regNo,
                              style: grey1Medium12TextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.02),
                              child: commonTextField(
                                controller: controller.regNo,
                                validator: (p0) {
                                  return null;
                                },
                              ),
                            ),

                            /// VEHICLE IMEI No
                            Text(
                              AppStrings.busDisplayDevice,
                              style: grey1Medium12TextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.02),
                              child: commonTextField(
                                readOnly: true,
                                controller: controller.imeiId,
                                validator: (p0) {
                                  return null;
                                },
                                onTap: () {
                                  showBusDisplayList(
                                    context,
                                    controller: controller,
                                    isFrom: 'createSection',
                                  );
                                },
                              ),
                            ),

                            /// GPS IMEI No
                            Text(
                              AppStrings.gpsDevice,
                              style: grey1Medium12TextStyle,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: height * 0.01, bottom: height * 0.02),
                            //   child: commonTextField(
                            //     controller: controller.gpsId,
                            //     validator: (p0) {},
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.02),
                              child: commonTextField(
                                readOnly: true,
                                controller: controller.gpsId,
                                validator: (p0) {
                                  return null;
                                },
                                onTap: () {
                                  showGpsDeviceList(context, controller: controller, isFrom: 'createSection');
                                },
                              ),
                            ),

                            Text(
                              AppStrings.addVehicleImage,
                              style: grey1Medium12TextStyle,
                            ),

                            GestureDetector(
                              onTap: () {
                                controller.pickGalleryImage();
                              },
                              child: Container(
                                height: height * 0.1,
                                width: width * 0.3,
                                margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color(0xffE8E8E8),
                                  ),
                                ),
                                child: controller.pickedImage == null
                                    ? const Icon(Icons.camera_alt)
                                    : Image.file(
                                        File(controller.pickedImage?.path ?? ''),
                                      ),
                              ),
                            ),
                            CommonButton(
                                onTap: () async {
                                  Map<String, String> body = {
                                    "chassis_no": controller.chasisId.text,
                                    "reg_no": controller.regNo.text,
                                    "bus_display": controller.busDisplayDeviceId,
                                    "gps_device": controller.gpsDeviceId,
                                    "status": 'false'
                                  };

                                  await controller.createVehicleRouteViewModel(
                                    body: body,
                                  );
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
}
