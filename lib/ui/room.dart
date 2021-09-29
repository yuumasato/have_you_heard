import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:have_you_heard/constants/colors.dart';
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
    return Scaffold(body: SafeArea(
      child: Consumer<GameState>(
        builder: (context, gameState, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.center,
                color: kBackgroundDarkGray,
                child: const Text(
                  'Sala Privada',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '# $roomID',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Aguardando jogadores...",
                            style: TextStyle(color: Colors.white),
                          ),
                          for (var player in gameState.allPlayers)
                            buildPlayerButton(player),
                        ]),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPinkButton,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/vote-persona');
                        },
                        child: const Text('Iniciar jogo')),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ));
  }

  Widget buildPlayerButton(String name) {
    return ElevatedButton(
      onPressed: null,
      child: Text(name),
    );
  }
}
