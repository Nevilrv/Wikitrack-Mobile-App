class ApiRouts {
  static String baseUrl = "http://134.209.145.234/api/v1/";

  ///auth
  static String login = "${baseUrl}accounts/login/fotax/web";
  static String register = "${baseUrl}accounts/fotax-register/";
  static String forgot = "${baseUrl}accounts/forgot/password/";
  static String resetPass = "${baseUrl}accounts/reset/password/";
  static String resendOtp = "${baseUrl}accounts/resend-otp/";
  static String confirmRegi = "${baseUrl}accounts/confirm-registration-otp/";

  ///route
  static String vehicleList = "${baseUrl}vehicles/tms/vehicle/list/";
  static String stopsList = "${baseUrl}vehicles/tms/stops/list/";
  static String busDisplayList = "${baseUrl}vehicles/bus-display/list/";
  static String gpsImeiList = "${baseUrl}vehicles/gps-imei/list/";
  static String stopDisplayList = "${baseUrl}vehicles/stop-display/list/";
  static String createVehicle = "${baseUrl}vehicles/create/tms/vehicle/";
  static String getTimeTableList = "${baseUrl}vehicles/timetable/list/";
  static String routeList = "${baseUrl}vehicles/tms/routes/list/";
  static String dailyRouteTripList = "${baseUrl}vehicles/daily-route-trip/list/";
}
