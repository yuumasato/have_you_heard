import 'package:get/get.dart';
import 'package:have_you_heard/models/game.dart';
import 'package:have_you_heard/models/socket.dart';

class GameController extends GetxController {
  int roomID = 42069;
  Game game = Game();
  Socket socket = Socket();

  void nextRound() {
    game.roundIndex += 1;
  }

  bool isGameFinished() {
    return game.roundIndex >=3;
  }

  void reset() {
    game.roundIndex = 0;
  }
}
