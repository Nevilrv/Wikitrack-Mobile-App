import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/views/forgotPassword/controller/forgot_password_controller.dart';
import 'package:wikitrack/views/login/controller/login_controller.dart';

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
      title: 'Wikitrak TMS Mobile App',
      initialBinding: ControllerBindings(),
      initialRoute: Routes.splashScreen,
      getPages: Routes.routes,
    );
  }
}

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => ForgotController());
    // Get.lazyPut(() => HandleNetworkConnection());
  }
}
