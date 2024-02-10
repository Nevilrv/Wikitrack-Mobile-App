import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();
  static String loginStatus = "loginStatus";
  static String registerStatus = "registerStatus";
  static String token = "token";

  static Future setLogin(bool value) async {
    await getStorage.write(loginStatus, value);
  }

  static getLogin() {
    return getStorage.read(loginStatus);
  }

  static Future setRegister(bool value) async {
    await getStorage.write(registerStatus, value);
  }

  static getRegister() {
    return getStorage.read(registerStatus);
  }

  static Future setToken(value) async {
    await getStorage.write(token, value);
  }

  static getToken() {
    return getStorage.read(token);
  }

  static clearAll() {
    getStorage.remove(loginStatus);
    getStorage.remove(registerStatus);
    getStorage.remove(token);
  }
}
