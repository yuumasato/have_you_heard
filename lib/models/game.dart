import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:have_you_heard/models/player.dart';

class Game {
  int roundIndex = 0;
  List<String> allNews = [
    'Pergunta 1',
    'Pergunta 2',
    'Pergunta 3',
  ];

  RxInt nPlayers = 0.obs;
  // The list always has a length of 6
  List<Player> playerList = <Player>[].obs;
  RxString ownerID = 'not_set'.obs;

  Game();

  void nextRound() {
    roundIndex += 1;
  }

  bool isGameFinished() {
    return roundIndex >=3;
  }

  void reset() {
    roundIndex = 0;
  }

  void setPlayers(List<dynamic> players, Player myPlayer) {
    nPlayers.value = players.length;
    playerList.clear();
    for (var index = 0; index < 6; index++) {
      Player player = Player(name:'Jogador ${index + 1}');
      if (index < nPlayers.value) {
        player = Player.fromJson(players[index]);
      }
      if (myPlayer.id == player.id) {
        // Always show myself as the first in the list of players
        playerList.insert(0, player);
      } else {
        playerList.add(player);
      }
    }
  }
}
