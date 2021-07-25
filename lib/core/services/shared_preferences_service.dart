import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> setIsLightTheme({bool lightTheme = true}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("light_theme", lightTheme);
  }

  Future<bool> isLightTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? val = prefs.getBool("light_theme");
    return val ?? false;
  }
}
