import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/response_model/confirm_regi_response_model.dart';
import 'package:wikitrack/response_model/resend_otp_responseModel.dart';
import 'package:wikitrack/utils/AppRoutes.dart';

class OtpController extends GetxController {
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

  Future<void> confirmRegi({required Map<String, dynamic> body}) async {
    update();
    http.Response response = await http.post(Uri.parse(ApiRouts.confirmRegi), body: body);

    if (response.statusCode == 200) {
      ConfirmRegiResponseModel responsee = ConfirmRegiResponseModel.fromJson(jsonDecode(response.body));
      update();

      commonSnackBar(message: "${responsee.status}");
      log("confirmRegi--------------> ${response.body}");
      Get.offAllNamed(Routes.homeScreen);
    } else {
      log("confirmRegi---e-----------> ${response.body}");
      ConfirmRegiResponseModel responsee = ConfirmRegiResponseModel.fromJson(jsonDecode(response.body));

      update();
      commonSnackBar(message: "${responsee.message}");
    }
  }

  /// Resend OTP
  Future<void> resendApiCall({required Map<String, dynamic> body}) async {
    update();
    http.Response response = await http.post(Uri.parse(ApiRouts.resendOtp), body: body);

    if (response.statusCode == 200) {
      ResendOtpResponseModel responsee = ResendOtpResponseModel.fromJson(jsonDecode(response.body));
      // isLoading = false;
      update();
      commonSnackBar(message: "${responsee.status}");
      log("ResendOtpResponseModel--------------> ${response.body}");
    } else {
      log("ResendOtpResponseModel---e-----------> ${response.body}");
      ResendOtpResponseModel responsee = ResendOtpResponseModel.fromJson(jsonDecode(response.body));
      // isLoading = false;
      update();
      commonSnackBar(message: "${responsee.status}");
    }
  }
}
