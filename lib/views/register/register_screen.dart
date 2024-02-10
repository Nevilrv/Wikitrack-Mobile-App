import 'dart:developer';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/common/commontextfield.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';
import 'package:wikitrack/response_model/register_response_model.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/utils/extension.dart';
import 'package:wikitrack/views/register/controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController transportController = TextEditingController();
  TextEditingController userTypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Scaffold(
      appBar: commonAppBar(
        title: AppStrings.userRegistration,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<RegisterController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.0.addHSpace(),
                    Center(
                      child: Text(
                        AppStrings.addPhoto,
                        style: greyMedium14TextStyle,
                      ),
                    ),
                    10.0.addHSpace(),
                    Stack(clipBehavior: Clip.none, children: [
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightGreyColor),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.2,
                                vertical: height * 0.02),
                            child: SvgPicture.asset(
                              AppImages.userProfile,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -height * 0.03,
                        left: 00,
                        right: 00,
                        child: GestureDetector(
                          onTap: () {
                            pickGalleryImage();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.whiteColor),
                            child: Padding(
                              padding: EdgeInsets.all(height * 0.007),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                    30.0.addHSpace(),
                    Text(
                      AppStrings.firstName,
                      style: greyMedium12TextStyle,
                    ),
                    8.0.addHSpace(),
                    commonTextField(
                        controller: firstNameController,
                        validator: (value) {
                          String pattern = r'^[a-z A-Z,.\-]+$';
                          RegExp regExp = RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Please enter Valid name';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid  name';
                          }
                          return null;
                        }),
                    24.0.addHSpace(),
                    Text(
                      AppStrings.lastName,
                      style: greyMedium12TextStyle,
                    ),
                    8.0.addHSpace(),
                    commonTextField(
                        controller: lastNameController,
                        validator: (value) {
                          String pattern = r'^[a-z A-Z,.\-]+$';
                          RegExp regExp = RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Please enter Valid last name';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid  last name';
                          }
                          return null;
                        }),
                    24.0.addHSpace(),
                    Text(
                      AppStrings.emailId,
                      style: greyMedium12TextStyle,
                    ),
                    8.0.addHSpace(),
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
                    24.0.addHSpace(),
                    Text(
                      AppStrings.password,
                      style: greyMedium12TextStyle,
                    ),
                    8.0.addHSpace(),
                    commonTextField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6 || value.length > 8) {
                            return 'Password must be between 6 and 8 characters';
                          }
                          return null;
                        }),
                    24.0.addHSpace(),
                    Text(
                      AppStrings.mobileNo,
                      style: greyMedium12TextStyle,
                    ),
                    8.0.addHSpace(),
                    commonTextField(
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Container(
                        width: 80,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        ),
                        child: Center(
                            child: IntlPhoneField(
                          readOnly: true,
                          decoration: InputDecoration(
                            counterText: '',
                            hintStyle: textGreyMedium16TextStyle,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          showCountryFlag: false,
                          initialCountryCode: 'IN',
                        )),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = new RegExp(pattern);

                        if (value!.isEmpty) {
                          return 'Please enter mobile number';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }

                        return null;
                      },
                    ),
                    24.0.addHSpace(),
                    Text(
                      AppStrings.transportService,
                      style: greyMedium12TextStyle,
                    ),
                    8.0.addHSpace(),
                    commonTextField(
                        controller: transportController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Transport Service is Required';
                          }
                          return null;
                        }),
                    24.0.addHSpace(),
                    Text(
                      AppStrings.userType,
                      style: greyMedium12TextStyle,
                    ),
                    8.0.addHSpace(),
                    commonTextField(
                        controller: userTypeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'User Type is Required';
                          }
                          return null;
                        }),
                    30.0.addHSpace(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.privacyPolicy,
                          style: greyMedium14TextStyle,
                          children: [
                            TextSpan(
                              text: '   Privacy Policy ',
                              style: greyMedium14TextStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                            TextSpan(
                                text: 'and ', style: greyMedium14TextStyle),
                            TextSpan(
                              text: ' Terms & Conditions',
                              style: greyMedium14TextStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller.isLoading == true
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
                        : Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.05, bottom: height * 0.01),
                            child: CommonButton(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Map<String, dynamic> body = {
                                      "device_type": Platform.isAndroid
                                          ? "android"
                                          : "ios",
                                      "email": emailController.text,
                                      "first_name": firstNameController.text,
                                      "last_name": lastNameController.text,
                                      "mac_id": "null",
                                      "mobile": mobileController.text,
                                      "password": passwordController.text,
                                      "serial_number": "null",
                                    };
                                    await controller.registerApiCall(
                                        body: body,
                                        arguments: {
                                          "email": emailController.text
                                        });
                                    //   if (controller.regiApiResponse.status == Status.COMPLETE) {
                                    //     RegisterResponseModel response = controller.regiApiResponse.data;
                                    //     PreferenceManager.setRegister(true);
                                    //     PreferenceManager.setToken("${response.token}");
                                    //     log('response::::::::::::::::::::==========>>>>>>>>>>>${response.token}');
                                    //   }
                                    //   if (controller.regiApiResponse.status == Status.ERROR) {
                                    //     commonSnackBar(message: 'Enter valid details');
                                    //     // ScaffoldMessenger.of(context).showSnackBar(
                                    //     //   const SnackBar(content: Text('Enter valid details')),
                                    //     // );
                                    //     // const SnackBar(
                                    //     //     content: Text('Error in Register'));
                                    //   }
                                  } else {
                                    commonSnackBar(
                                        message: 'Enter valid details');
                                  }
                                },
                                title: AppStrings.submit),
                          ),
                    20.0.addHSpace(),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.alreadyAccount,
                          style: textGreyMedium16TextStyle.copyWith(
                              color: AppColors.greyColor),
                          children: [
                            TextSpan(
                              text: ' Login',
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => Get.toNamed(Routes.loginScreen),
                              style: textGreyMedium16TextStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    40.0.addHSpace(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  pickGalleryImage({int? index}) async {
    log("hello");
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = image;

      // Uint8List bytes = await pickedImage!.readAsBytes();
      //
      // pickedImageBase64 = base64.encode(bytes);
      // pickedImageExtension = pickedImage!.name.split('.').last;
      setState(() {});
    }
  }

  /// pick image
  pickCameraImage({int? index}) async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage = image;

      // Uint8List bytes = await pickedImage!.readAsBytes();
      //
      // pickedImageBase64 = base64.encode(bytes);
      // pickedImageExtension = pickedImage!.name.split('.').last;
      if (mounted) {
        setState(() {});
      }
    }
  }
}
