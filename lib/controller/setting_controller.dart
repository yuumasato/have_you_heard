import 'package:shared_preferences/shared_preferences.dart';

Future setLanguagePref (String lang) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('locale', lang);
}

Future setNamePref (String name) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('username', name);
}