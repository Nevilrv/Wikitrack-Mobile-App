import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/Apis/api_response.dart';
import 'package:wikitrack/Repo/auth_repo.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';

import 'package:wikitrack/response_model/login_Response_model.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  bool isVisible = false;
  bool isLoading = false;

  changeVisibility() {
    isVisible = !isVisible;
    update();
  }

  ///login API

  // ApiResponse _loginApiResponse = ApiResponse.initial(message: 'Initialization');
  //
  // ApiResponse get loginApiResponse => _loginApiResponse;
  // Future loginViewModel({required Map<String, dynamic> body}) async {
  //   isLoading = true;
  //   update();
  //   _loginApiResponse = ApiResponse.loading(message: 'Loading');
  //
  //   update();
  //   try {
  //     LoginResponseModel response = await AuthRepo().loginRepo(body: body);
  //     _loginApiResponse = ApiResponse.complete(response);
  //     log("response==${response}");
  //     log("response==${response.statusCode}");
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Get.toNamed(Routes.homeScreen);
  //     }
  //
  //     isLoading = false;
  //     update();
  //   } catch (e) {
  //     _loginApiResponse = ApiResponse.error(message: e.toString());
  //     log("_loginApiResponse==>${e.toString()}");
  //     isLoading = false;
  //     update();
  //   }
  //   update();
  // }

  Future<void> loginApiCall({required Map<String, dynamic> body}) async {
    isLoading = true;
    update();
    http.Response response = await http.post(Uri.parse(ApiRouts.login), body: body);

    if (response.statusCode == 200) {
      LoginResponseModel responsee = LoginResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      PreferenceManager.setLogin(true);
      PreferenceManager.setToken("${responsee.token}");
      commonSnackBar(message: 'Login Successfully');
      Get.toNamed(Routes.homeScreen);
      // Get.toNamed(Routes.otpForgot);
      log("response--------------> ${response.body}");
    } else {
      log("response---e-----------> ${response.body}");

      LoginResponseModel responsee = LoginResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      commonSnackBar(message: responsee.error);
    }
  }
}
