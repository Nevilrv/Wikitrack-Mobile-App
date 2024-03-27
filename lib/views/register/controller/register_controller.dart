import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/common/common_snackbar.dart';
import 'package:wikitrack/preference_manager/preference_Manager.dart';

import 'package:wikitrack/response_model/register_response_model.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  // ApiResponse _regiApiResponse = ApiResponse.initial(message: 'Initialization');
  //
  // ApiResponse get regiApiResponse => _regiApiResponse;
  // Future registerViewModel({required Map<String, dynamic> body}) async {
  //   update();
  //   _regiApiResponse = ApiResponse.loading(message: 'Loading');
  //
  //   update();
  //   try {
  //     RegisterResponseModel response = await AuthRepo().registerRepo(body: body);
  //     _regiApiResponse = ApiResponse.complete(response);
  //     log("response==${response}");
  //     log("response==${response.lastName}");
  //     log("response==${response.statusCode}");
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Get.toNamed(Routes.homeScreen);
  //     }
  //
  //     update();
  //   } catch (e) {
  //     _regiApiResponse = ApiResponse.error(message: e.toString());
  //     debugPrint("_loginApiResponse==>${e.toString()}");
  //
  //     update();
  //   }
  //   update();
  // }
  bool isLoading = false;
  Future<void> registerApiCall(
      {required Map<String, dynamic> body,
      Map<String, dynamic>? arguments}) async {
    isLoading = true;
    update();
    http.Response response =
        await http.post(Uri.parse(ApiRouts.register), body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      RegisterResponseModel responsee =
          RegisterResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      PreferenceManager.setLogin(true);
      PreferenceManager.setToken("${responsee.token}");
      commonSnackBar(message: 'Register Successfully');
      // commonSnackBar(message: 'Register Successfully');
      // Get.toNamed(Routes.homeScreen);
      Get.toNamed(Routes.otpScreen, arguments: arguments);
      log("response--------------> ${response.body}");
    } else {
      log("response---e-----------> ${response}");
      var res = jsonDecode(response.body);
      log("response---e-----------> ${res['mobile'][0]}");
      // log("response---e-----------> ${res['email'][0]}");

      // RegisterResponseModel responsee = RegisterResponseModel.fromJson(jsonDecode(response.body));
      isLoading = false;
      update();
      if (res['message'] != null) {
        RegisterResponseModel responsee =
            RegisterResponseModel.fromJson(jsonDecode(response.body));
        // PreferenceManager.setLogin(true);
        // PreferenceManager.setToken("${responsee.token}");
        commonSnackBar(message: responsee.message);
      } else {
        if (res['email'] == null) {
          commonSnackBar(message: res['mobile'][0]);
        } else {
          commonSnackBar(message: res['email'][0]);
        }
      }
      // commonSnackBar(message: res['mobile'][0]);
    }
  }
}
