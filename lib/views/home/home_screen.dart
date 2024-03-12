import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/home/controller/home_controller.dart';
import 'package:wikitrack/views/reports/report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  HomeController homeController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getHomeScreenData();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      key: _key,
      appBar: commonImageAppBar(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          image: SvgPicture.asset(
            AppImages.homeLogo,
            // height: height * 0.07,
          )),
      drawer: buildDrawer(width, height),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  children: [
                    commonContainer(
                      height,
                      width,
                      AppImages.vehicle,
                      AppStrings.vehicle,
                      '${controller.vehicleLength}',
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    commonContainer(
                      height,
                      width,
                      AppImages.stop,
                      AppStrings.stops,
                      '${controller.stopsLength}',
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    commonContainer(
                      height,
                      width,
                      AppImages.routes,
                      AppStrings.routes,
                      '${controller.routesLength}',
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Drawer buildDrawer(double width, double height) {
    return Drawer(
        width: width * 0.55,
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Center(child: SvgPicture.asset(AppImages.whiteLogo, height: height * 0.037, width: height * 0.037)),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      commonDrawerTile(height, AppStrings.busStopDisplay, AppImages.busStop, () {
                        _key.currentState!.closeDrawer();
                        Get.toNamed(Routes.busStopDisplayScreen);
                      }),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonDrawerTile(height, AppStrings.busDisplay, AppImages.busDisplay, () {
                        _key.currentState!.closeDrawer();
                        Get.toNamed(Routes.busDisplayScreen);
                      }),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonDrawerTile(height, AppStrings.liveMap, AppImages.liveMap, () {
                        _key.currentState!.closeDrawer();
                        Get.toNamed(Routes.liveMapScreen);
                      }),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonDrawerTile(height, AppStrings.tripHistory, AppImages.tripHistory, () {
                        _key.currentState!.closeDrawer();
                        Get.toNamed(Routes.tripHistoryScreen);
                      }),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonDrawerTile(height, AppStrings.reports, AppImages.report, () {
                        _key.currentState!.closeDrawer();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ReportScreen();
                          },
                        ));
                        // Get.toNamed(Routes.reportScreen);
                      }),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonDrawerTile(height, AppStrings.settings, AppImages.setting, () {
                        _key.currentState!.closeDrawer();
                        Get.toNamed(Routes.settingScreen);
                      }),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      commonDrawerTile(height, AppStrings.logout, AppImages.logout, () {
                        PreferenceManager.clearAll();
                        Get.offAllNamed(Routes.loginScreen);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  GestureDetector commonDrawerTile(double height, String title, String image, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.15,
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(image, height: height * 0.06, width: height * 0.06),
              SizedBox(
                height: height * 0.005,
              ),
              Text(
                title,
                style: blackMedium16TextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded commonContainer(double height, double width, String image, String title, String count) {
    return Expanded(
      child: Container(
        height: height * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.blackColor.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(image, height: height * 0.025, width: height * 0.025),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      title,
                      style: blackMedium14TextStyle,
                    )
                  ],
                ),
                Text(
                  count,
                  style: primaryBold20TextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
