import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/models/player.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/widgets/in_game_app_bar.dart';
import 'package:have_you_heard/widgets/lost_game_dialog.dart';
import 'package:have_you_heard/widgets/won_game_dialog.dart';

import 'room.dart';

class GameWinnerScreen extends StatefulWidget {
  const GameWinnerScreen({Key? key}) : super(key: key);

  static const routeName = '/game-winner';
  static const route = '/game-winner';

  @override
  _GameWinnerScreenState createState() => _GameWinnerScreenState();
}

class _GameWinnerScreenState extends State<GameWinnerScreen>
    with SingleTickerProviderStateMixin {
  final GameController gc = Get.find();
  late AnimationController _controller;
  late Animation<double> _roundsBar;
  late Animation<double> _tieBar;
  final Duration _screenDuration = const Duration(seconds: 8);
  Player _gameWinner = Player(name: 'No player');

  String winnerBanner = 'No banner';
  double _tieEnd = 0.0;

  int count = 0;
  double mostWins = 0.0;

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
    int animeTime = 6000;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animeTime),
    );
    _controller.addListener(() {
      setState(() {});
    });

    _gameWinner = gc.game.gameWinner ?? Player(name: 'No player');

    getMostWins();

    _roundsBar = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.3, curve: Curves.easeOutCirc))
    );

    if (gc.game.tie) {
      _tieEnd = 1.0;
      winnerBanner = 'wonRounds'.tr;
      Future.delayed(Duration(milliseconds: animeTime~/2), () {
        setState(() {
          winnerBanner = 'fastestPlayers'.tr;
        });
      });
      Future.delayed(Duration(milliseconds: animeTime), () {
        setState(() {
          winnerBanner = _gameWinner.name + 'winner'.tr;
        });
      });
    } else {
      winnerBanner = _gameWinner.name + 'winner'.tr;
    }
    _tieBar = Tween<double>(begin: 0.0, end: _tieEnd)
        .animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOutCirc))
    );

    _controller.forward();
    Future.delayed(_screenDuration, () {
      route();
    });
  }

  getMostWins() {
    for (var p in gc.game.playerList) {
      if (p.roundWins > mostWins) {
        mostWins = p.roundWins.toDouble();
      }
    }
    if (gc.game.tie) {
      mostWins += 1;
    }
  }

  bool isGameWinner(){
    if(_gameWinner.name == gc.myPlayer.name){
      return true;
    }
    return false;
  }

  onPlayAgain(){
    gc.game.reset();
    String roomID = gc.roomID;
    Get.offAllNamed("${RoomScreen.route}/$roomID");
  }

  onExitGame(){
    gc.exitGame();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  route() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          // A choice must be made in this dialog, let's block the back button
            onWillPop: () async => false,
            child: isGameWinner()?
            WonGameDialog(onPLayAgainPressed: onPlayAgain, onEndGamePressed: onExitGame):
            LostGameDialog(onPLayAgainPressed: onPlayAgain, onEndGamePressed: onExitGame,)));
  }

  @override
  Widget build(BuildContext context) {
    List<Player> allPlayers = gc.game.playerList;
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return WillPopScope(
      // This is short lived screen, let's block the back button
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: const InGameAppBar(),
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
                            child: Text(winnerBanner,
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...buildPlayerButton(_gameWinner),
                        ],
                      ),
                    )
                  ],
                ))));
  }

  List<Widget> buildPlayerButton(Player winner) {
    final appBarHeight = AppBar().preferredSize.height;
    List<Widget> playerButtons = <Widget>[];

    for (var index = 0; index < 6; index++) {
      Player player = Player(name: 'player'.trParams({'number': '${index + 1}'}));
      bool visible = false;
      double barValue = 0.0;
      if (index < gc.game.nPlayers.value) {
        player = gc.game.playerList[index];
        barValue = (_roundsBar.value * player.roundWins + (player.id == winner.id ? _tieBar.value : 0.0))/mostWins;
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
                value: barValue,
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
