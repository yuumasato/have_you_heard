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

List<String> allPlayers = [
  'Nickname 1',
  'Nickname 2',
  'Nickname 3',
  'Nickname 4',
  'Nickname 5',
  'Nickname 6',
];
List<double?> loadingValues = [0, 0.3, 0.5, 0.7, 1, null];
List<Color> playerColors = [
  kPlayer_1,
  kPlayer_2,
  kPlayer_3,
  kPlayer_4,
  kPlayer_5,
  kPlayer_6
];

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
    final roomID = Get.parameters['roomID'];
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: AppBar().preferredSize.height * 0.73,
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Aguardando jogadores...",
                    style: TextStyle(color: Colors.white),
                  ),
                  for (var index = 0; index < 6; index++)
                    buildPlayerButton(index),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: AppBar().preferredSize.height * 0.5,
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: kPinkButton,
                    fixedSize: Size(screenWidth * 0.8,
                        AppBar().preferredSize.height * 0.08),
                  ),
                  onPressed: () {
                    Get.offNamed(VotePersonaScreen.route);
                  },
                  child: const Text('Iniciar jogo')),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlayerButton(int i) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: AppBar().preferredSize.height * 0.08),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          LinearProgressIndicator(
            value: loadingValues[i],
            color: playerColors[i],
            minHeight: AppBar().preferredSize.height * 0.66,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(allPlayers[i]),
              ),
              Visibility(
                child: const Icon(Icons.check),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: loadingValues[i] == 1 ? true : false,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
