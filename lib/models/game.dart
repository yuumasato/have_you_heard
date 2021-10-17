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
  String persona = "not_set";

  RxInt nPlayers = 0.obs;
  // The list always has a length of 6
  List<Player> playerList = <Player>[].obs;

  String roundWinnerID = 'not_set';

  Game();

  void nextRound() {
    roundIndex += 1;
    roundWinnerID = 'not_set';
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
    if (roundIndex >= allHeadlines.length) {
      return "";
    }
    return allHeadlines[roundIndex];
  }

  String getWinnerHeadline() {
    if (roundIndex >= allHeadlines.length) {
      return "";
    }
    String currentHeadline = allHeadlines[roundIndex];
    String winnerHeadline = currentHeadline.replaceAll(RegExp(r'_+'), '(Resposta X)');
    return winnerHeadline;
  }

  String getCorrectHeadline() {
    if (roundIndex >= allHeadlines.length) {
      return "";
    }
    String currentHeadline = allHeadlines[roundIndex];
    String correctHeadline = currentHeadline.replaceAll(RegExp(r'_+'), '(Correta)');
    return correctHeadline;
  }

  void setAnswers(Map<String, String> answers, Player myPlayer) {
    for (var p in playerList) {
      p.answer = answers[p.id] ?? 'not_set';
    }
  }
}
