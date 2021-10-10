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

  int nPlayers = 0;
  // The list always has a length of 6
  List<Player> playerList = <Player>[].obs;

  Game();

  void setPlayers(List<dynamic> players, Player myPlayer) {
    nPlayers = players.length;
    playerList.clear();
    for (var index = 0; index < 6; index++) {
      Player player = Player(name:'Jogador ${index + 1}');
      if (index < nPlayers) {
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
