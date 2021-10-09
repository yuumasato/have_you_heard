import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/models/game.dart';
import 'package:have_you_heard/models/socket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  int roomID = 42069;
  String userID = 'not_set';

  Game game = Game();
  Socket socket = Socket();

  late bool onBoarded;
  String username = 'not_set';
  String language = 'not_set';

  GameController() {
    getOnboardedState();
  }

  void nextRound() {
    game.roundIndex += 1;
  }

  bool isGameFinished() {
    return game.roundIndex >=3;
  }

  void reset() {
    game.roundIndex = 0;
  }

  void exitGame() {
    reset();
    socket.leaveRoom();
  }

  Future<bool> getOnboardedState() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? 'not_set';
    language = prefs.getString('locale') ?? 'not_set';

    if (username != 'not_set' && language != 'not_set') {
      onBoarded = true;
      setLocale(language);
      socket.initUser(username);
      return true;
    } else {
      onBoarded = false;
      return false;
    }
  }

  void setLocale (String language) {
    if (language == 'es') {
      var locale = Locale('es', 'AR');
      Get.updateLocale(locale);
    } else {
      var locale = Locale('pt', 'BR');
      Get.updateLocale(locale);
    }
  }

  void initUser(String username) {
    this.username = username;
    socket.initUser(username);
  }

  void saveUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  void createRoom() {
    socket.createRoom();
  }

  void joinRoom(int roomID) {
    socket.joinRoom(roomID);
  }

}
