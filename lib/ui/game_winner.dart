import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'room.dart';

class GameWinnerScreen extends StatefulWidget {
  const GameWinnerScreen({Key? key}) : super(key: key);

  static const routeName = '/game-winner';
  static const route = '/game-winner';

  @override
  _GameWinnerScreenState createState() => _GameWinnerScreenState();
}

class _GameWinnerScreenState extends State<GameWinnerScreen> {
  @override
  initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() async {
    final GameController gc = Get.find();
    await showDialog(
        context: context,
        builder: (_) =>
            SimpleDialog(
              title: const Text('Parabéns'),
              children: <Widget>[
                Image.asset('assets/images/trophy.png'),
                ElevatedButton(
                    onPressed: () {
                      // Reinstate a new Game State
                      gc.reset();
                      int roomID = gc.roomID;
                      Get.offAllNamed("${RoomScreen.route}/$roomID");
                    },
                    child: const Text('Jogar Novamente')),
                TextButton(
                    onPressed: () {
                      gc.exitGame();
                    },
                    child: const Text('Finalizar partida'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
    return Scaffold(
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Ranking'),
                const Text('Nickname 4\nVencedor!'),
                for (var player in gc.game.playerList) buildPlayerButton(player),
              ],
            )
        )
    );
  }

  Widget buildPlayerButton(String name) {
    return ElevatedButton(
        onPressed: null,
        child: Text(name));
  }
}
