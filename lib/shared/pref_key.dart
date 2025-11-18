import 'package:shared_preferences/shared_preferences.dart';

class PREFSKey {
  static String accessToken = "access_token";
  static String refreshToken = "refresh_token";

  //Set Access Token
  Future<bool> setAccessToken(String token) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool status = await sf.setString(accessToken, token);
    return status;
  }

  //Get Access Token
  Future<String?> getAccessToken() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = await sf.getString(accessToken);
    return token;
  }

  //Set Refresh Token
  Future<bool> setRefreshToken(String token) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool status = await sf.setString(refreshToken, token);
    return status;
  }

  //Get Refresh Token
  Future<String?> getRefreshToken() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = await sf.getString(refreshToken);
    return token;
  }

  //theme set and get
  Future<bool> setThemeIsDark(bool value) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool status = await sf.setBool('isDarkTheme', value);
    return status;
  }

  Future<bool?> getThemeIsDark() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool? result = sf.getBool('isDarkTheme');
    return result;
  }

  Future<bool> removeThemeIsDark() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool status = await sf.remove('isDarkTheme');
    return status;
  }

  static Future<bool?> setIsClockedOut(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool("_isClockedOutKey", value);
  }

  static Future<bool?> getIsClockedOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("_isClockedOutKey") ?? false;
  }

  static Future<bool?> resetIsClockedOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove("_isClockedOutKey");
  }
}
