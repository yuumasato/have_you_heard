import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> get langLocale => {
  'es': 'AR',
  'pt': 'BR',
};

Future setGameLanguage (GameController gc, String lang) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('locale', lang);
  gc.language = lang;

  var locale = Locale(lang, langLocale[lang]);
  Get.updateLocale(locale);
  gc.socket.sendLang(lang);
}