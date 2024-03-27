import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/forgotPassword/controller/forgot_password_controller.dart';

class ForgotAddPasswordScreen extends StatefulWidget {
  const ForgotAddPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotAddPasswordScreen> createState() =>
      _ForgotAddPasswordScreenState();
}

class _ForgotAddPasswordScreenState extends State<ForgotAddPasswordScreen> {
  ForgotController forgotController = Get.put(ForgotController());
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      appBar: commonAppBar(
        title: AppStrings.forgotPassword,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<ForgotController>(
        builder: (controller) {
          return Form(
            key: _formKey3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    AppStrings.newPassword,
                    style: greyMedium12TextStyle,
                  ),
                  TextFormField(
                    style: textGreyMedium16TextStyle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter New Password';
                      }
                    },
                    controller: passwordController,
                    obscureText: !controller.isVisible1,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCCCCCC), width: 1)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCCCCCC), width: 1)),
                      hintText: AppStrings.enterPassword,
                      hintStyle: textGreyMedium16TextStyle,
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: IconButton(
                          onPressed: () {
                            controller.changeVisibility1();
                          },
                          icon: controller.isVisible1
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    AppStrings.confirmPassword,
                    style: greyMedium12TextStyle,
                  ),
                  TextFormField(
                    style: textGreyMedium16TextStyle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Confirm Password';
                      }
                    },
                    obscureText: !controller.isVisible1,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCCCCCC), width: 1)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCCCCCC), width: 1)),
                      hintText: AppStrings.enterPassword,
                      hintStyle: textGreyMedium16TextStyle,
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: IconButton(
                          onPressed: () {
                            controller.changeVisibility1();
                          },
                          icon: controller.isVisible1
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  CommonButton(
                      onTap: () {
                        if (_formKey3.currentState!.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            log('  key: _formKey,::::::::::::::::::::==========>>>>>>>>>>>');

                            Map<String, dynamic> body = {
                              "email": Get.arguments["email"],
                              "otp": Get.arguments["password"],
                              "new_password": confirmPasswordController.text,
                            };
                            controller.addPassApiCall(body: body);
                          } else {
                            commonSnackBar(
                                message:
                                    "New password and confirm password are not match!");
                          }
                        } else {
                          commonSnackBar(
                              message:
                                  "Password and confirm password are not matched!");
                        }
                      },
                      title: AppStrings.forgotPassword),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
