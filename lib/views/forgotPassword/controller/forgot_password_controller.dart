import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/response_model/add_password_responseModel.dart';
import 'package:wikitrack/response_model/forgot_password_res_model.dart';
import 'package:http/http.dart' as http;
import 'package:wikitrack/response_model/resend_otp_responseModel.dart';
import 'package:wikitrack/utils/AppRoutes.dart';

class ForgotController extends GetxController {
  bool isVisible1 = false;
  changeVisibility1() {
    isVisible1 = !isVisible1;
    update();
  }

  bool isVisible2 = false;

  changeVisibility2() {
    isVisible2 = !isVisible2;
    update();
  }

  ///time

  int second = 120;
  Timer? timer;
  changeTimerSecond() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (second == 0) {
        timer.cancel();
        second = 120;
      } else {
        second = second - 1;
      }
      update();
    });
  }

  ///forgot password api
  // ApiResponse _forgotPasswordRepo = ApiResponse.initial(message: 'Initialization');
  //
  // ApiResponse get forgotPasswordRepo => _forgotPasswordRepo;
  // Future forgotPasswordViewModel({required Map<String, dynamic> body}) async {
  //   update();
  //   _forgotPasswordRepo = ApiResponse.loading(message: 'Loading');
  //
  //   update();
  //   try {
  //     ForgotPasswordResModel response = await AuthRepo().forgotPasswordRepo(body: body);
  //     _forgotPasswordRepo = ApiResponse.complete(response);
  //     log("response==${response}");
  //     // log("response==${response.statusCode}");
  //     update();
  //   } catch (e) {
  //     _forgotPasswordRepo = ApiResponse.error(message: e.toString());
  //     // ForgotPasswordResModel response = ForgotPasswordResModel(detail: e['meesage']);
  //     log("_forgotPasswordRepo==>${e.toString()}");
  //     update();
  //   }
  //   update();
  // }

  bool isLoading = false;
  Future<void> forgotApiCall(
      {required Map<String, dynamic> body,
      Map<String, dynamic>? arguments}) async {
    isLoading = true;
    update();
    http.Response response =
        await http.post(Uri.parse(ApiRouts.forgot), body: body);

    if (response.statusCode == 200) {
      ForgotPasswordResModel responsee =
          ForgotPasswordResModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(message: responsee.detail);
      Get.offAllNamed(Routes.otpForgot, arguments: arguments);
      log("response--------------> ${response.body}");
    } else {
      log("response---e-----------> ${response.body}");
      ForgotPasswordResModel responsee =
          ForgotPasswordResModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(message: responsee.detail);
    }
  }

  /// add Password
  Future<void> addPassApiCall({required Map<String, dynamic> body}) async {
    isLoading = true;
    update();
    http.Response response =
        await http.post(Uri.parse(ApiRouts.resetPass), body: body);

    if (response.statusCode == 200) {
      AddPasswordResponseModel responsee =
          AddPasswordResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(message: responsee.detail);
      Get.offAllNamed(Routes.loginScreen);
      log("commonSnackBar--------------> ${response.body}");
    } else {
      log("commonSnackBar---e-----------> ${response.body}");
      ForgotPasswordResModel responsee =
          ForgotPasswordResModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(message: responsee.detail);
    }
  }

  /// Resend OTP
  Future<void> resendApiCall({required Map<String, dynamic> body}) async {
    update();
    http.Response response =
        await http.post(Uri.parse(ApiRouts.resendOtp), body: body);

    if (response.statusCode == 200) {
      ResendOtpResponseModel responsee =
          ResendOtpResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(message: "${responsee.status}");
      log("ResendOtpResponseModel--------------> ${response.body}");
    } else {
      log("ResendOtpResponseModel---e-----------> ${response.body}");
      ResendOtpResponseModel responsee =
          ResendOtpResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(message: "${responsee.status}");
    }
  }
}
