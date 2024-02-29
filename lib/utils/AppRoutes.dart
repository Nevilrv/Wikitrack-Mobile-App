import 'package:get/get.dart';

import 'package:wikitrack/views/bus_display/bus_display_screen.dart';
import 'package:wikitrack/views/bus_stop_display/bus_stop_display.dart';
import 'package:wikitrack/views/forgotPassword/forgot_add_password_screen.dart';
import 'package:wikitrack/views/home/home_screen.dart';
import 'package:wikitrack/views/live_map/live_map_screen.dart';
import 'package:wikitrack/views/login/login_screen.dart';
import 'package:wikitrack/views/forgotPassword/otp_forgot_screen.dart';
import 'package:wikitrack/views/otp/otp_screen.dart';
import 'package:wikitrack/views/register/register_screen.dart';
import 'package:wikitrack/views/reports/daily_trip_report/daily_trip_report_screen.dart';
import 'package:wikitrack/views/reports/report_screen.dart';
import 'package:wikitrack/views/settings/dailyTripManagement/daily_trip_management.dart';
import 'package:wikitrack/views/settings/routeManagement/map.dart';
import 'package:wikitrack/views/settings/routeManagement/route_management.dart';
import 'package:wikitrack/views/settings/vehicleManagement/vehicle_management.dart';
import 'package:wikitrack/views/splash/splash_screen.dart';
import 'package:wikitrack/views/trip_history/trip_history_screen.dart';
import '../views/forgotPassword/forgot_password_screen.dart';
import '../views/settings/busTimeTable/busTImeTable.dart';
import '../views/settings/setting_screen.dart';

class Routes {
  static String splashScreen = "/splashScreen";
  static String loginScreen = "/loginScreen";
  static String otpScreen = "/OtpScreen";
  static String homeScreen = "/HomeScreen";
  static String settingScreen = "/SettingScreen";
  static String liveMapScreen = "/LiveMapScreen";
  static String routeManagement = "/RouteManagement";
  static String registerScreen = "/registerScreen";
  static String vehicleManagement = "/vehicleManagement";
  static String routineTripManagement = "/routineTripManagement";
  static String dailyTripManagement = "/dailyTripManagement";
  static String forgotPassword = "/ForgotPasswordScreen";
  static String otpForgot = "/OTPForgotScreen";
  static String mapScreen = "/mapScreen";
  static String forgotAddPassword = "/ForgotAddPasswordScreen";

  static String tripHistoryScreen = "/TripHistoryScreen";
  static String reportScreen = "/ReportScreen";
  static String dailyTripReportScreen = "/DailyTripReportScreen";
  static String busStopDisplayScreen = "/BusStopDisplayScreen";
  static String busDisplayScreen = "/BusDisplayScreen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: otpScreen, page: () => const OTPScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: settingScreen, page: () => const SettingScreen()),
    GetPage(name: liveMapScreen, page: () => const LiveMapScreen()),
    GetPage(name: routeManagement, page: () => const RouteManagement()),
    GetPage(name: vehicleManagement, page: () => const VehicleManagement()),
    GetPage(name: routineTripManagement, page: () => const BusTimeTable()),
    GetPage(name: dailyTripManagement, page: () => const DailyTripManagement()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: otpForgot, page: () => const OTPForgotScreen()),
    GetPage(name: forgotAddPassword, page: () => const ForgotAddPasswordScreen()),
    GetPage(name: mapScreen, page: () => const MapScreen()),
    GetPage(name: tripHistoryScreen, page: () => const TripHistoryScreen()),
    GetPage(name: reportScreen, page: () => const ReportScreen()),
    GetPage(name: busDisplayScreen, page: () => const BusDisplayScreen()),
    GetPage(name: busStopDisplayScreen, page: () => const BusStopDisplayScreen()),
    GetPage(name: dailyTripReportScreen, page: () => const DailyTripReportScreen()),
  ];
}
