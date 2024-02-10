import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/utils/AppStrings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      appBar: commonSubTitleAppBar(
        title: AppStrings.settings,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            buildContainerTile(height, width, AppStrings.routeManage, AppImages.routeManage, () {
              Get.toNamed(Routes.routeManagement);
            }),
            SizedBox(
              height: height * 0.02,
            ),
            buildContainerTile(height, width, AppStrings.vehicleManage, AppImages.vehicleManage, () {
              Get.toNamed(Routes.vehicleManagement);
            }),
            SizedBox(
              height: height * 0.02,
            ),
            buildContainerTile(height, width, AppStrings.routineTripManage, AppImages.routineTrip, () {
              Get.toNamed(Routes.routineTripManagement);
            }),
            SizedBox(
              height: height * 0.02,
            ),
            buildContainerTile(height, width, AppStrings.dailyTripManage, AppImages.dailyTripManage, () {
              Get.toNamed(Routes.dailyTripManagement);
            }),
          ],
        ),
      ),
    );
  }

  GestureDetector buildContainerTile(double height, double width, String title, String image, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: AppColors.blackColor.withOpacity(0.1), blurRadius: 4, offset: Offset(0, 2))],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              SvgPicture.asset(image, height: height * 0.033, width: height * 0.033),
              SizedBox(
                width: width * 0.03,
              ),
              Text(
                title,
                style: blackMedium14TextStyle,
              ),
              Spacer(),
              SvgPicture.asset(AppImages.arrawRight)
            ],
          ),
        ),
      ),
    );
  }
}
