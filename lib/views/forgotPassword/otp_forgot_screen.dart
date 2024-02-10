import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/forgotPassword/controller/forgot_password_controller.dart';

class OTPForgotScreen extends StatefulWidget {
  const OTPForgotScreen({Key? key}) : super(key: key);

  @override
  State<OTPForgotScreen> createState() => _OTPForgotScreenState();
}

class _OTPForgotScreenState extends State<OTPForgotScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  ForgotController forgotController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      forgotController.changeTimerSecond();
    });
    // TODO: implement initState
    super.initState();
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  void dispose() {
    forgotController.timer!.cancel();
    forgotController.second = 120;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    final defaultPinTheme = PinTheme(
      width: Get.height * 0.085,
      height: Get.height * 0.085,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGreyColor),
      ),
    );
    return Scaffold(
      appBar: commonAppBar(
        title: AppStrings.otpVerification,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<ForgotController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Text(
                  AppStrings.sendOtpString,
                  style: blackMedium14TextStyle,
                ),
                Text(
                  '${Get.arguments["email"] ?? ""}',
                  style: blackMedium14TextStyle,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: Text(
                    '${formattedTime(timeInSecond: controller.second)}',
                    style: primaryBold20TextStyle,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  defaultPinTheme: defaultPinTheme,
                  // separatorBuilder: (index) => const SizedBox(width: 8),
                  // validator: (value) {
                  //   return value == '2222' ? null : 'Pin is incorrect';
                  // },
                  // onClipboardFound: (value) {
                  //   debugPrint('onClipboardFound: $value');
                  //   pinController.setText(value);
                  // },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme,
                  submittedPinTheme: defaultPinTheme,
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.notReceiveOTP,
                      style: grey1Medium12TextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.second == 120) {
                          log("helllo");
                          Map<String, dynamic> body = {
                            "email": Get.arguments["email"],
                          };
                          controller.resendApiCall(body: body);
                          controller.changeTimerSecond();
                        } else {}
                      },
                      child: Text(
                        AppStrings.resend,
                        style: controller.second == 120
                            ? primaryBold12TextStyle
                            : primaryBold12TextStyle.copyWith(color: AppColors.primaryColor.withOpacity(0.1)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                controller.second == 120
                    ? Container(
                        height: Get.height * 0.065,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Center(child: Text(AppStrings.submit, style: whiteMedium16TextStyle)),
                      )
                    : CommonButton(
                        onTap: () {
                          if (pinController.text.isEmpty) {
                            commonSnackBar(message: "Please enter otp");
                          } else {
                            // controller.second = 120;
                            // controller.timer!.cancel();
                            Get.toNamed(Routes.forgotAddPassword,
                                arguments: {"email": Get.arguments["email"], "password": pinController.text});
                          }
                        },
                        title: AppStrings.submit),
                // CommonButton(
                //     onTap: () {
                //       Get.offAllNamed(Routes.forgotAddPassword, arguments: {
                //         "email": Get.arguments["email"],
                //         "password": pinController.text
                //       });
                //     },
                //     title: AppStrings.submit),
              ],
            ),
          );
        },
      ),
    );
  }
}
