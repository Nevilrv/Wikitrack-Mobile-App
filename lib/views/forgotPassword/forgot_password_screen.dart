import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/views/forgotPassword/controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  ForgotController controller = Get.put(ForgotController());
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
      body: Form(
        key: _formKey2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                AppStrings.forgotPasswordString,
                style: blackMedium14TextStyle,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                AppStrings.email,
                style: greyMedium12TextStyle,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              commonTextField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is Required';
                    }
                    if (!RegExp(
                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                        .hasMatch(value)) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  }),
              SizedBox(
                height: height * 0.1,
              ),
              GetBuilder<ForgotController>(
                builder: (controller) {
                  return controller.isLoading == true
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.05, bottom: height * 0.01),
                          child: Container(
                            height: Get.height * 0.065,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            )),
                          ),
                        )
                      : CommonButton(
                          onTap: () async {
                            if (_formKey2.currentState!.validate()) {
                              await controller.forgotApiCall(body: {
                                "email": emailController.text
                              }, arguments: {
                                "email": emailController.text,
                              });
                            } else if (emailController.text.isEmpty) {
                              commonSnackBar(message: "Please enter email");
                            } else {
                              commonSnackBar(
                                  message: "Please enter valid email");
                            }
                          },
                          title: AppStrings.forgotPassword);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
