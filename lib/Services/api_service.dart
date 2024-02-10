import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../apis/app_exception.dart';

enum APIType {
  aPost,
  aGet,
  aPut,
}

enum HeaderType {
  hAppJson,
  hUrlencoded,
}

class APIService {
  var response;

  Future getResponse(
      {required String url,
      required APIType apitype,
      HeaderType? headerType,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    debugPrint("Authorization>>>>>$header");

    try {
      if (apitype == APIType.aGet) {
        debugPrint("URL======>>>>> $url");
        final result = await http.get(Uri.parse(url), headers: header);
        response = returnResponse(result.statusCode, result.body);
      } else if (apitype == APIType.aPut) {
        debugPrint("REQUEST PARAMETER ======>>>>> ${jsonEncode(body)}");

        final result = await http.put(
          Uri.parse(url),
          body: body,
        );

        response = returnResponse(result.statusCode, result.body);
      } else {
        debugPrint("URL======>>>>> $url");
        final result = await http.post(Uri.parse(url), body: body);

        Map<String, dynamic> mapResponse = jsonDecode(result.body);

        Map<String, dynamic> statusResponse = {'statusCode': result.statusCode};

        mapResponse.addAll(statusResponse);
        response = returnResponse(result.statusCode, jsonEncode(mapResponse));
        log('response::::::::::::::::::::==========>>>>>>>>>>>${response}');
      }
    } on SocketException {
      throw FetchDataException('No Internet access');
    }

    return response;
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 201:
        return jsonDecode(result);
      // case 204:
      //   return {
      //     "status": "SUCCESS",
      //     "message": "SuccessFully Query List Get",
      //     "data": []
      //   };
      case 400:
        return jsonDecode(result);
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw jsonDecode(result);
      // throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
