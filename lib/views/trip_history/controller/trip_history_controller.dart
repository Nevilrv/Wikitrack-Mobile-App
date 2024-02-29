import 'dart:developer';

import 'package:get/get.dart';
import 'package:wikitrack/socket/socket_service.dart';

class TripHistoryController extends GetxController {
  var lat;
  var long;
  int indexCheck = 0;
  Future<void> getLiveMapDataListener() async {
    getSocketAllAngleOn();
  }

  Future<void> getSocketLiveMapData() async {
    SocketConnection.socket!.emit(
      'locationinfo',
      {},
    );
  }

  getSocketAllAngleOn() {
    SocketConnection.socket!.on("locationinfo", (data) {
      log('locationinfo>>> ${data.runtimeType}');
      log('locationinfo>>> ${data}');

      update();
    });
  }
}
