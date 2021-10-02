import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'vote_persona.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  static const routeName = '/room/:roomID';
  static const route = '/room';

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
    final roomID = Get.parameters['roomID'];
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(body: SafeArea(
      child: Column(
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Aguardando jogadores...",
                      style: TextStyle(color: Colors.white),
                    ),
                    for (var player in gc.game.allPlayers)
                      buildPlayerButton(player),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPinkButton,
                    ),
                    onPressed: () {
                      Get.offNamed(VotePersonaScreen.route);
                    },
                    child: const Text('Iniciar jogo')),
              ),
            ],
          )
    ));
  }

  Widget buildPlayerButton(String name) {
    return ElevatedButton(
      onPressed: null,
      child: Text(name),
    );
  }
}
