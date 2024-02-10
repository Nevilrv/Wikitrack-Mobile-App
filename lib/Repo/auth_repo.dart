import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wikitrack/Services/api_service.dart';
import 'package:wikitrack/Services/base_service.dart';
import 'package:wikitrack/response_model/add_password_responseModel.dart';
import 'package:wikitrack/response_model/forgot_password_res_model.dart';
import 'package:wikitrack/response_model/login_Response_model.dart';
import 'package:wikitrack/response_model/register_response_model.dart';
import 'package:wikitrack/response_model/resend_otp_responseModel.dart';

class AuthRepo {
  ///login
  Future<dynamic> loginRepo({required Map<String, dynamic> body}) async {
    try {
      var response = await APIService()
          .getResponse(url: ApiRouts.login, body: body, apitype: APIType.aPost);
      log('response $response');

      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(response);

      return loginResponseModel;
    } catch (e) {
      log("loginResponseModel-----ERROR===$e");
    }
  }

  ///sign up
  Future<dynamic> registerRepo({required Map<String, dynamic> body}) async {
    try {
      var response = await APIService().getResponse(
          url: ApiRouts.register, body: body, apitype: APIType.aPost);
      debugPrint('response $response');
      RegisterResponseModel registerResponseModel =
          RegisterResponseModel.fromJson(response);

      return registerResponseModel;
    } catch (e) {
      debugPrint("registerResponseModel-----ERROR===$e");
    }
  }

  ///forgot password
  Future<dynamic> forgotPasswordRepo(
      {required Map<String, dynamic> body}) async {
    try {
      var response = await APIService().getResponse(
          url: ApiRouts.forgot, body: body, apitype: APIType.aPost);
      log('response $response');
      ForgotPasswordResModel forgotPasswordResModel =
          ForgotPasswordResModel.fromJson(response);

      return forgotPasswordResModel;
    } catch (e) {
      log("registerResponseModel-----ERROR===$e");
    }
  }

  ///add password

  Future<dynamic> addPasswordRepo({required Map<String, dynamic> body}) async {
    try {
      var response = await APIService().getResponse(
          url: ApiRouts.resetPass, body: body, apitype: APIType.aPost);
      log('response $response');
      AddPasswordResponseModel addPasswordResponseModel =
          AddPasswordResponseModel.fromJson(response);

      return addPasswordResponseModel;
    } catch (e) {
      log("registerResponseModel-----ERROR===$e");
    }
  }

  ///resend OTP

  Future<dynamic> resendOtpRepo({required Map<String, dynamic> body}) async {
    try {
      var response = await APIService().getResponse(
          url: ApiRouts.resendOtp, body: body, apitype: APIType.aPost);
      log('response $response');
      ResendOtpResponseModel responseModel =
          ResendOtpResponseModel.fromJson(response);

      return responseModel;
    } catch (e) {
      log("registerResponseModel-----ERROR===$e");
    }
  }
}
