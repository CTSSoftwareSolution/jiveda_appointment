import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static SharedPreferences? instance;

  static String mobileNumber = "mobileNumber";

  static Future<void> setPreferences() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) {
    return instance!.setString(key, value);
  }

  static dynamic getString(String key) {
    return instance!.get(key) ?? "";
  }

  static Future<bool> setMobileNumber(String value) => setString(mobileNumber, value);
  static dynamic getMobileNumber() => getString(mobileNumber);
}