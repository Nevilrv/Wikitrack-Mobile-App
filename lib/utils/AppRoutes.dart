import 'package:get/get.dart';

import 'package:wikitrack/views/forgotPassword/forgot_add_password_screen.dart';
import 'package:wikitrack/views/home/home_screen.dart';
import 'package:wikitrack/views/login/login_screen.dart';
import 'package:wikitrack/views/forgotPassword/otp_forgot_screen.dart';
import 'package:wikitrack/views/otp/otp_screen.dart';
import 'package:wikitrack/views/register/register_screen.dart';
import 'package:wikitrack/views/settings/dailyTripManagement/daily_trip_management.dart';
import 'package:wikitrack/views/settings/routeManagement/route_management.dart';

import 'package:wikitrack/views/settings/vehicleManagement/vehicle_management.dart';
import 'package:wikitrack/views/splash/splash_screen.dart';

import '../views/forgotPassword/forgot_password_screen.dart';
import '../views/settings/busTimeTable/busTImeTable.dart';
import '../views/settings/setting_screen.dart';

class Routes {
  static String splashScreen = "/";
  static String loginScreen = "/loginScreen";
  static String otpScreen = "/OtpScreen";
  static String homeScreen = "/HomeScreen";
  static String settingScreen = "/SettingScreen";
  static String routeManagement = "/RouteManagement";
  static String registerScreen = "/registerScreen";
  static String vehicleManagement = "/vehicleManagement";
  static String routineTripManagement = "/routineTripManagement";
  static String dailyTripManagement = "/dailyTripManagement";
  static String forgotPassword = "/ForgotPasswordScreen";
  static String otpForgot = "/OTPForgotScreen";
  static String forgotAddPassword = "/ForgotAddPasswordScreen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: otpScreen, page: () => const OTPScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: settingScreen, page: () => const SettingScreen()),
    GetPage(name: routeManagement, page: () => const RouteManagement()),
    GetPage(name: vehicleManagement, page: () => const VehicleManagement()),
    GetPage(name: routineTripManagement, page: () => const BusTimeTable()),
    GetPage(name: dailyTripManagement, page: () => const DailyTripManagement()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: otpForgot, page: () => const OTPForgotScreen()),
    GetPage(name: forgotAddPassword, page: () => const ForgotAddPasswordScreen()),
  ];
}
