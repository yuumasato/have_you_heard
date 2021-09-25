import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  static const routeName = '/room';

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    final roomID = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        body: SafeArea(
          child: Consumer<GameState>(
            builder:(context, gameState, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Sala Privada'),
                  Text('# $roomID'),
                  for (var player in gameState.allPlayers) buildPlayerButton(player),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/vote-persona');
                      },
                      child: const Text('Iniciar jogo')),
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
