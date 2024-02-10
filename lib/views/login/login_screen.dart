import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';
import 'package:wikitrack/response_model/login_Response_model.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: height * 0.4,
                color: AppColors.primaryColor,
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        AppImages.whiteLogo,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.016,
                    ),
                    Text(
                      AppStrings.welcome,
                      style: whiteMedium28TextStyle,
                    ),
                    Text(
                      AppStrings.pleaseLoginToContinue,
                      style: whiteMedium16TextStyle,
                    ),
                  ],
                )),
              ),
              Container(
                height: height * 0.6,
                color: AppColors.whiteColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        AppImages.splashTitle,
                        height: height * 0.2,
                        width: height * 0.2,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            left: 0,
            top: height * 0.27,
            child: GetBuilder<LoginController>(
              builder: (controller) {
                return Container(
                  height: height * 0.42,
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.045),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.mobileNo,
                          style: greyMedium12TextStyle,
                        ),
                        TextFormField(
                          controller: mobileController,
                          style: textGreyMedium16TextStyle,
                          decoration: InputDecoration(
                            enabledBorder:
                                const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffCCCCCC), width: 1)),
                            focusedBorder:
                                const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffCCCCCC), width: 1)),
                            hintText: AppStrings.mobileNo,
                            hintStyle: textGreyMedium16TextStyle,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          AppStrings.password,
                          style: greyMedium12TextStyle,
                        ),
                        TextFormField(
                          controller: passwordController,
                          style: textGreyMedium16TextStyle,
                          obscureText: !controller.isVisible,
                          decoration: InputDecoration(
                            enabledBorder:
                                const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffCCCCCC), width: 1)),
                            focusedBorder:
                                const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffCCCCCC), width: 1)),
                            hintText: AppStrings.enterPassword,
                            hintStyle: textGreyMedium16TextStyle,
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: IconButton(
                                onPressed: () {
                                  controller.changeVisibility();
                                },
                                icon: controller.isVisible
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(
                                        Icons.visibility_off_outlined,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        controller.isLoading == true
                            ? Padding(
                                padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.01),
                                child: Container(
                                  height: Get.height * 0.065,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8)),
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                  )),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.01),
                                child: CommonButton(
                                  title: AppStrings.signIn,
                                  onTap: () async {
                                    if (mobileController.text.isEmpty) {
                                      commonSnackBar(message: "Please enter mobile no");
                                    } else if (passwordController.text.isEmpty) {
                                      commonSnackBar(message: "Please enter password");
                                    } else {
                                      Map<String, dynamic> body = {
                                        "mobile": mobileController.text,
                                        "password": passwordController.text,
                                      };

                                      log('body::::::::::::::::::::==========>>>>>>>>>>>${body}');
                                      await controller.loginApiCall(body: body);
                                    }

                                    // Get.toNamed(Routes.homeScreen);
                                  },
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.registerScreen);
                              },
                              child: Text(AppStrings.register, style: greyMedium14TextStyle),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed(Routes.forgotPassword);
                              },
                              child: Text(AppStrings.forgotPassword, style: greyMedium14TextStyle),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
