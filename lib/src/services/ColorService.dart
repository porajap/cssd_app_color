import 'package:cssd_app_color/src/models/ColorsSettingModel.dart';
import 'package:cssd_app_color/src/utils/PreferenceKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorService {
  Future<ColorSettingModel> getSetting() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String bradfordA = _prefs.getString(PreferenceKey.bradfordA) ?? '';
    String bradfordB = _prefs.getString(PreferenceKey.bradfordB) ?? '';
    String lowryA = _prefs.getString(PreferenceKey.lowryA) ?? '';
    String lowryB = _prefs.getString(PreferenceKey.lowryB) ?? '';

    if (bradfordA == '') {
      _prefs.setString(PreferenceKey.bradfordA, '2.453');
      bradfordA = _prefs.getString(PreferenceKey.bradfordA) ?? '';
    }
    if (bradfordB == '') {
      _prefs.setString(PreferenceKey.bradfordB, '1.159');
      bradfordB = _prefs.getString(PreferenceKey.bradfordB) ?? '';
    }
    if (lowryA == '') {
      _prefs.setString(PreferenceKey.lowryA, '0.4486');
      lowryA = _prefs.getString(PreferenceKey.lowryA) ?? '';
    }
    if (lowryB == '') {
      _prefs.setString(PreferenceKey.lowryB, '0.4786');
      lowryB = _prefs.getString(PreferenceKey.lowryB) ?? '';
    }

    ColorSettingModel _result = ColorSettingModel.fromJson({
      'bradfordA': bradfordA,
      'bradfordB': bradfordB,
      'lowryA': lowryA,
      'lowryB': lowryB,
    });

    return _result;
  }

  Future<String> saveSetting({
    String bradfordA,
    String bradfordB,
    String lowryA,
    String lowryB,
  }) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceKey.bradfordA, bradfordA);
    _prefs.setString(PreferenceKey.bradfordB, bradfordB);
    _prefs.setString(PreferenceKey.lowryA, lowryA);
    _prefs.setString(PreferenceKey.lowryB, lowryB);
    return 'Success!';
  }
}
