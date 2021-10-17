import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/models/player.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';
import 'package:have_you_heard/constants/colors.dart';

import 'room.dart';

class GameWinnerScreen extends StatefulWidget {
  const GameWinnerScreen({Key? key}) : super(key: key);

  static const routeName = '/game-winner';
  static const route = '/game-winner';

  @override
  _GameWinnerScreenState createState() => _GameWinnerScreenState();
}

class _GameWinnerScreenState extends State<GameWinnerScreen> {
  final GameController gc = Get.find();
  Timer? timer;

  int count = 0;
  //List<int> votes = [1, 2, 7, 7, 3, 0];
  double mostWins = 0.0;
  List<double> votesValues = [0.015, 0.015, 0.015, 0.015, 0.015, 0.015];

  List<Color> playerColors = [
    kPlayer_1,
    kPlayer_2,
    kPlayer_3,
    kPlayer_4,
    kPlayer_5,
    kPlayer_6
  ];

  @override
  initState() {
    super.initState();
    getMostVotes();
    startTime();
    startAnimationTimer();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  startAnimationTimer() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, animationProgressTimer);
  }

  animationProgressTimer() async {
    timer = Timer.periodic(
        const Duration(milliseconds: 10), (_) => setVotesValues());
  }

  setVotesValues() {
    setState(() {
      List<Player> p = gc.game.playerList;
      for (int i = 0; i < p.length; i++) {
        if (p[i].roundWins != 0) {
          votesValues[i] = (p[i].roundWins * count) / (mostWins * 100);
        }
      }
    });
    if (count > 100) {
      timer!.cancel();
    }
    count++;
  }

  getMostVotes() {
    for (var p in gc.game.playerList) {
      if (p.roundWins > mostWins) {
        mostWins = p.roundWins.toDouble();
      }
    }
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  route() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            // A choice must be made in this dialog, let's block the back button
            onWillPop: () async => false,
            child: SimpleDialog(
              title: const Center(child: Text('Parabéns')),
              titleTextStyle: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: kYellow),
              children: <Widget>[
                Image.asset('assets/images/trophy.png'),
                AppButton(
                    onPressed: () {
                      // Reinstate a new Game State
                      gc.game.reset();
                      String roomID = gc.roomID;
                      Get.offAllNamed("${RoomScreen.route}/$roomID");
                    },
                    color: kPink,
                    textColor: kGrayScaleLightest,
                    text:'Jogar Novamente'),
                TextButton(
                    onPressed: () {
                      gc.exitGame();
                    },
                    child: const Text('Finalizar partida'))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    List<Player> allPlayers = gc.game.playerList;
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    Player _gameWinner = gc.game.gameWinner ?? Player(name: 'No player');

    return WillPopScope(
      // This is short lived screen, let's block the back button
        onWillPop: () async {
          startTime();
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const GrayStripe(text: 'Ranking'),
                    Container(
                      padding: EdgeInsets.only(
                          bottom: appBarHeight * 0.50,
                          left: screenWidth * 0.1,
                          right: screenWidth * 0.1),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: appBarHeight * 0.50),
                            child: Text(
                              _gameWinner.name + '\nVencedor!',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...buildPlayerButton(),
                        ],
                      ),
                    )
                  ],
                ))));
  }

  List<Widget> buildPlayerButton() {
    final appBarHeight = AppBar().preferredSize.height;
    List<Widget> playerButtons = <Widget>[];

    for (var index = 0; index < 6; index++) {
      Player player = Player(name: 'Jogador ${index + 1}');
      bool visible = false;
      if (index < gc.game.nPlayers.value) {
        player = gc.game.playerList[index];
        visible = true;
      }
      playerButtons.add(Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: visible,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: appBarHeight * 0.13),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Stack(alignment: AlignmentDirectional.center, children: [
              LinearProgressIndicator(
                value: votesValues[index],
                color: playerColors[index],
                minHeight: appBarHeight * 0.66,
                backgroundColor: kGrayScaleMediumDark,
              ),
              Text(player.name),
            ]),
          ),
        ),
      ));
    }
    return playerButtons;
  }
}
