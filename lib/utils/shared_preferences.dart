import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {
  Future<bool> getVoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool sex = prefs.getBool('sex');
    if (sex == null) {
      sex = true;
      setVoice(true);
    }
    return sex;
  }

  void setVoice(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sex', value);
  }

  Future<bool> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool language = prefs.getBool('language');
    return language;
  }

  void setLanguage(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('language', value);
  }

  Future<bool> isOpenSale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('openPaywall');
    count = count == null ? 1 : count + 1;
    count < 3 ? await prefs.setInt('openPaywall', count) : await prefs.remove('openPaywall');
    return count == 3;
  }

  Future<bool> isFirstOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstOpen') == null;
  }
}
