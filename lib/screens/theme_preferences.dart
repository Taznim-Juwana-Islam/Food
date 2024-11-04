import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String _themeKey = 'theme';

  // Get the saved theme preference (either 'dark' or 'light')
  static Future<String?> getThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey);
  }

  // Save the selected theme preference
  static Future<void> saveThemePreference(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_themeKey, theme);
  }
}
