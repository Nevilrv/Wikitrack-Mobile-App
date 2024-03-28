import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';

import 'package:wikitrack/response_model/login_Response_model.dart';
import 'package:wikitrack/utils/app_routes.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  bool isVisible = false;
  bool isLoading = false;

  changeVisibility() {
    isVisible = !isVisible;
    update();
  }

  /// Login Api
  Future<void> loginApiCall({required Map<String, dynamic> body}) async {
    isLoading = true;
    update();

    http.Response response =
        await http.post(Uri.parse(ApiRouts.login), body: body);

    if (response.statusCode == 200) {
      LoginResponseModel loginResModel =
          LoginResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      PreferenceManager.setLogin(true);
      PreferenceManager.setToken("${loginResModel.token}");
      commonSnackBar('Login Successfully');
      Get.offAllNamed(Routes.homeScreen);

      log("LOGIN ERROR SUCCESS--------------> ${response.body}");
    } else {
      log("LOGIN API ERROR-----------> ${response.body}");

      LoginResponseModel loginResModel =
          LoginResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(loginResModel.error);
    }
  }
}
