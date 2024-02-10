import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/commonDialogue.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/utils/extension.dart';

class VehicleManagement extends StatefulWidget {
  const VehicleManagement({super.key});

  @override
  State<VehicleManagement> createState() => _VehicleManagementState();
}

class _VehicleManagementState extends State<VehicleManagement> {
  PageController _pageController1 = PageController();
  List images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo1kplxuW3G9gRB4FmZCrRSQX4L4eGgGCehg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSn6Z_UAIXa3CAnmwBlxhQc_oLu1yfL76HKQTGFLdwBNlZR8mLaYyEXQHHGkprKTinZNsA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI8c-zCsoeYWWPfAamYIrRx3lE8GDgYFMyR_ukS3z3QElmw252JvP_0b09TqGt8A3neeQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0dE2Y6IuhgiZbxc7oUhwrhD3qfJRMwoBXYsTZACBFlkjB-QMdvCunJeRvlCmPEA5YIgw&usqp=CAU',
  ];
  int selector = 0;
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
      floatingActionButton: CircleAvatar(
        // radius: 20,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
          size: 25,
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
              CommonButton(
                  title: AppStrings.selectVehicle,
                  onTap: () {
                    showDataAlert(context, text: AppStrings.selectVehicle);
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
                        duration: Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.iconGreyColor),
                          shape: BoxShape.circle),
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
                      physics: BouncingScrollPhysics(),
                      controller: _pageController1,
                      onPageChanged: (value) {
                        setState(() {
                          selector = value;
                        });
                      },
                      children: List.generate(
                        images.length,
                        (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController1.nextPage(
                        duration: Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.iconGreyColor),
                          shape: BoxShape.circle),
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
              commonBorderButton(title: AppStrings.chassisID),
              SizedBox(
                height: height * 0.02,
              ),
              commonBorderButton(title: AppStrings.regNo),
              SizedBox(
                height: height * 0.02,
              ),
              commonBorderButton(title: AppStrings.selectBus),
              SizedBox(
                height: height * 0.02,
              ),
              commonBorderButton(title: AppStrings.selectGPS),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
