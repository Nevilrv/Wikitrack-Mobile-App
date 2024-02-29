import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wikitrack/socket/controller/socket_controller.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/views/bus_display/controller/bus_display_controller.dart';
import 'package:wikitrack/views/forgotPassword/controller/forgot_password_controller.dart';
import 'package:wikitrack/views/login/controller/login_controller.dart';
import 'package:wikitrack/views/reports/controller/report_controller.dart';
import 'package:wikitrack/views/splash/splash_screen.dart';
import 'package:wikitrack/views/trip_history/controller/trip_history_controller.dart';

import 'views/live_map/controller/live_map_controller.dart';
import 'views/settings/controller/setting_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      title: 'Wikitrack TMS Mobile App',
      initialBinding: ControllerBindings(),
      // initialRoute: Routes.splashScreen,
      // home: Home(),
      home: SplashScreen(),
      getPages: Routes.routes,
    );
  }
}

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => ForgotController(), fenix: true);
    Get.lazyPut(() => SettingController(), fenix: true);
    Get.lazyPut(() => LiveMapController(), fenix: true);
    Get.lazyPut(() => SocketController(), fenix: true);
    Get.lazyPut(() => TripHistoryController(), fenix: true);
    Get.lazyPut(() => ReportController(), fenix: true);
    Get.lazyPut(() => BusDisplayController(), fenix: true);
    // Get.lazyPut(() => HandleNetworkConnection());
  }
}
