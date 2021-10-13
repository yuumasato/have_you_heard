import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/models/game.dart';
import 'package:have_you_heard/models/player.dart';
import 'package:have_you_heard/models/socket.dart';
import 'package:have_you_heard/ui/vote_persona.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  String roomID = '42069';
  Player myPlayer = Player();

  Game game = Game();
  Socket socket = Socket();

  late bool onBoarded;
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
    var playerName = prefs.getString('username') ?? 'not_set';
    var language = prefs.getString('locale') ?? 'not_set';

    if (playerName != 'not_set' && language != 'not_set') {
      onBoarded = true;
      setLocale(language);
      setPlayerName(playerName);
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

  void setPlayerName(String playerName) {
    myPlayer.name = playerName;
    socket.initUser(playerName);
  }

  void saveUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  void createRoom() {
    socket.createRoom();
  }

  void joinRoom(String roomID) {
    socket.joinRoom(roomID);
  }

  void startGame(){
    socket.startGame();
    Get.offNamed(VotePersonaScreen.route);
  }
}
