import 'package:cssd_app_color/src/utils/PreferenceKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorService {
  Future<int> getCountDocument() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _depId = _prefs.getString(PreferenceKey.depId) ?? '';
    int _result = 0;
    if (_response.statusCode == 200) {
      _result = int.parse(_response.body);
    } else {
      throw Exception('Failed to load post');
    }
    return _result;
  }
}