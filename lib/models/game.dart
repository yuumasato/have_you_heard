import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class Game {
  int roundIndex = 0;
  List<String> allNews = [
    'Pergunta 1',
    'Pergunta 2',
    'Pergunta 3',
  ];

  int nPlayers = 0;
  // The list always has a length of 6
  List<String> playerList = <String>[].obs;

  Game();

  void setPlayers(List<dynamic> players, String ownUserID) {
    nPlayers = players.length;
    playerList.clear();
    for (var index = 0; index < 6; index++) {
      var userID = 'Jogador ${index + 1}';
      if (index < nPlayers) {
        userID = players[index] as String;
      }
      if (ownUserID == userID) {
        // Always show myself as the first in the list of players
        playerList.insert(0, userID);
      } else {
        playerList.add(userID);
      }
    }
  }
}
