import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/views/home/home_screen.dart';
import 'package:wikitrack/views/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Get.offAll(PreferenceManager.getLogin() == true||PreferenceManager.getRegister() == true
            ? () => const HomeScreen()
            : () => const LoginScreen());
        // Get.toNamed(Routes.loginScreen);
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: [
              AppColors.primaryColor.withOpacity(0.2),
              AppColors.primaryColor,
            ],
            radius: 0.8,
            center: Alignment.center,
            tileMode: TileMode.clamp,
            focalRadius: 0.3,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * 0.2,
                    width: height * 0.2,
                  ),
                  SizedBox(height: height * 0.01),
                ],
              ),
              Center(child: SvgPicture.asset(AppImages.splashLogo)),
              Column(
                children: [
                  Center(
                      child: SvgPicture.asset(
                    AppImages.splashTitle,
                    height: height * 0.2,
                    width: height * 0.2,
                  )),
                  SizedBox(height: height * 0.01),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
