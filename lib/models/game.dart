import 'package:get/get.dart';
import 'package:have_you_heard/models/player.dart';

import 'news.dart';

class Game {
  int roundIndex = 0;
  List<News> allNews = [];
  String persona = "not_set";

  RxInt nPlayers = 0.obs;
  // The list always has a length of 6
  List<Player> playerList = <Player>[].obs;

  Player? roundWinner;
  Player? gameWinner;
  bool tie = false;

  Game();

  void nextRound() {
    roundIndex += 1;
    roundWinner = null;
  }

  bool isGameFinished() {
    return roundIndex >=3;
  }

  void reset() {
    roundIndex = 0;
    gameWinner = null;
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

  void setNews(List<dynamic> news) {
    allNews.clear();
    for (var index = 0; index < news.length; index++) {
      allNews.add(News.fromJson(news[index]));
    }
  }

  String getBlankHeadline() {
    if (roundIndex >= allNews.length) {
      return "";
    }
    String currentHeadline = allNews[roundIndex].headline;
    return currentHeadline.replaceAll(RegExp(r'\[.*]'), '________');
  }

  String getWinnerHeadline() {
    if (roundIndex >= allNews.length) {
      return "";
    }
    String currentHeadline = allNews[roundIndex].headline;
    String winnerHeadline = currentHeadline.replaceAll(
        RegExp(r'\[.*]'), roundWinner?.answer ?? 'No answer');
    return winnerHeadline;
  }

  String getCorrectHeadline() {
    if (roundIndex >= allNews.length) {
      return "";
    }
    String currentHeadline = allNews[roundIndex].headline;
    String correctHeadline = currentHeadline.replaceAll(
        RegExp(r'\[|]'), '');
    return correctHeadline;
  }

  void setAnswers(Map<String, String> answers, Player myPlayer) {
    for (var p in playerList) {
      p.answer = answers[p.id] ?? 'not_set';
    }
  }

  Player getPlayerByID(String id) {
    Player player = Player(name: 'Not found');
    for (var p in playerList) {
      if (p.id == id) {
         player = p;
      }
    }
    return player;
  }

  int getRoundWinnerIndex() {
    int i;
    for (i = 0; i < playerList.length; i++) {
      if (playerList[i].id == roundWinner?.id) {
        return i+1;
      }
    }
    return 1;
  }

  void setPlayerWins(Map<String, int> wins) {
    for (var p in playerList) {
      p.roundWins = wins[p.id] ?? 0;
    }
  }
}
