import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:have_you_heard/models/player.dart';

class Game {
  int roundIndex = 0;
  List<String> allHeadlines = [
    'Pergunta 1',
    'Pergunta 2',
    'Pergunta 3',
  ];
  int persona = -1;

  RxInt nPlayers = 0.obs;
  // The list always has a length of 6
  List<Player> playerList = <Player>[].obs;

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

  void setHeadlines(List<String> headlines) {
    allHeadlines.clear();
    allHeadlines.assignAll(headlines);
  }

  String getBlankHeadline() {
    return allHeadlines[roundIndex];
  }

  String getWinnerHeadline() {
    String currentHeadline = allHeadlines[roundIndex];
    String winnerHeadline = currentHeadline.replaceAll(RegExp(r'_+'), '(Resposta X)');
    return winnerHeadline;
  }

  String getCorrectHeadline() {
    String currentHeadline = allHeadlines[roundIndex];
    String correctHeadline = currentHeadline.replaceAll(RegExp(r'_+'), '(Correta)');
    return correctHeadline;
  }
}
