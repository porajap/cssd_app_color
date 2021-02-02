import 'package:cssd_app_color/src/models/UserModel.dart';
import 'package:cssd_app_color/src/services/Url.dart';
import 'package:http/http.dart' as http;
import 'package:cssd_app_color/src/utils/PreferenceKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {

  Future<bool> checkLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    return _prefs.getBool(PreferenceKey.isLogin) ?? false;
  }

  Future<bool> login({UserModel user}) async {

    if (user != null) {

      if (user.username == "pose" && user.password == "pose") {
        SharedPreferences _prefs = await SharedPreferences.getInstance();

        _prefs.setBool(PreferenceKey.isLogin, true);
        _prefs.setString(PreferenceKey.userID, user.username);
        _prefs.setString(PreferenceKey.firstName,user.username);
        _prefs.setString(PreferenceKey.lastName, user.username);

        if (user.isRemember) {
          _prefs.setString(PreferenceKey.userName, user.username);
        }
        _prefs.setBool(PreferenceKey.isRemember, user.isRemember);

        return true;
      }  else{
        return false;
      }
    }
    return false;
  }


  Future<void> logout() async {

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(PreferenceKey.isLogin);
    _prefs.remove(PreferenceKey.firstName);
    _prefs.remove(PreferenceKey.lastName);
    _prefs.remove(PreferenceKey.userID);
    _prefs.clear();

    return await Future<void>.delayed(Duration(seconds: 1));
  }
}
