import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';
import 'lobby.dart';
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
                      Provider.of<GameState>(context, listen:false).reset();
                      int roomID = Provider.of<HyhState>(context, listen:false).roomID;
                      Get.offAllNamed("${RoomScreen.route}/$roomID");
                    },
                    child: const Text('Jogar Novamente')),
                TextButton(
                    onPressed: () => Get.offAllNamed(LobbyScreen.route),
                    child: const Text('Finalizar partida'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer<GameState>(
            builder:(context, gameState, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Ranking'),
                  const Text('Nickname 4\nVencedor!'),
                  for (var player in gameState.allPlayers) buildPlayerButton(player),
                ],
              );
            },
          ),
        )
    );
  }

  Widget buildPlayerButton(String name) {
    return ElevatedButton(
        onPressed: null,
        child: Text(name));
  }
}
