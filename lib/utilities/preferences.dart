import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static SharedPreferences? instance;

  static String mobileNumber = "mobileNumber";
  static String userId = "userId";
  static String userName = "userName";
  static String patientId = "patientId";
  static String email = "email";
  static String mobile = "mobile";
  static String firstName = "firstName";
  static String lastName = "lastName";
  static String patientName = "patientName";
  static String tokenId = "tokenId";
  static String roleId = "roleId";
  static String orgName = "orgName";
  static String orgServiceProviderId = "orgServiceProviderId";

  static Future<void> setPreferences() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() => instance!.clear();

  static Future<bool> setString(String key, String value) {
    return instance!.setString(key, value);
  }

  static dynamic getString(String key) {
    return instance!.get(key) ?? "";
  }

  static Future<bool> setMobileNumber(String value) => setString(mobileNumber, value);
  static Future<bool> setUserId(String value) => setString(userId, value);
  static Future<bool> setUserName(String value) => setString(userName, value);
  static Future<bool> setPatientId(String value) => setString(patientId, value);
  static Future<bool> setEmail(String value) => setString(email, value);
  static Future<bool> setMobile(String value) => setString(mobile, value);
  static Future<bool> setFirstName(String value) => setString(firstName, value);
  static Future<bool> setLastName(String value) => setString(lastName, value);
  static Future<bool> setPatientName(String value) => setString(patientName, value);
  static Future<bool> setTokenId(String value) => setString(tokenId, value);
  static Future<bool> setRoleId(String value) => setString(roleId, value);
  static Future<bool> setOrgName(String value) => setString(orgName, value);
  static Future<bool> setOrgServiceProviderId(String value) => setString(orgServiceProviderId, value);

  static dynamic getMobileNumber() => getString(mobileNumber);
  static dynamic getUserId() => getString(userId);
  static dynamic getUserName() => getString(userName);
  static dynamic getPatientId() => getString(patientId);
  static dynamic getEmail() => getString(email);
  static dynamic getMobile() => getString(mobile);
  static dynamic getFirstName() => getString(firstName);
  static dynamic getLastName() => getString(lastName);
  static dynamic getPatientName() => getString(patientName);
  static dynamic getTokenId() => getString(tokenId);
  static dynamic getRoleId() => getString(roleId);
  static dynamic getOrgName() => getString(orgName);
  static dynamic getOrgServiceProviderId() => getString(orgServiceProviderId);
}