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
  static String createStopSeq = "${baseUrl}vehicles/stopsequence/create/";
  static String createStop = "${baseUrl}vehicles/stops/create/";
  static String createRoutes = "${baseUrl}vehicles/routes/create/";

  static String updateVehicle = "${baseUrl}vehicles/update/tms/vehicle/";

  ///

  // static String dailyTripRegister = "${baseUrl}vehicles/tms/vehicle/list/";
  static String createTimeSlot = "${baseUrl}vehicles/routetrip/create/";

  ///

  static String createBusTimeSlot = "${baseUrl}vehicles/timeslot/create/";
  static String createBusDaySlot = "${baseUrl}vehicles/dayslot/create/";
  // http://139.59.37.47:3031/ccServer/location/getImeiToReg
  ///location
  static String getImeiToReg = "http://139.59.37.47:3031/ccServer/location/getImeiToReg";
  static String getDailyRouteTripFilter = "${baseUrl}vehicles/daily-route-trip/list/?";
  static String vehicleRouteTrip = "${baseUrl}vehicles/vehicle-route-trip/list/?reg_no=";
  static String createStopTime = "${baseUrl}vehicles/stopactualtime/create/";
  static String getTimeByRegNo = "${baseUrl}vehicles/stop-actual-time/list/?reg_no=";
  static String getTimeByRouteNo = "${baseUrl}vehicles/stop-actual-time/list/?route_no=";
}
