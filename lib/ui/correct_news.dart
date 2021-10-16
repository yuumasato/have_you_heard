import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'game_winner.dart';
import 'show_news.dart';

import 'package:have_you_heard/constants/colors.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';

class CorrectNewsScreen extends StatefulWidget {
  const CorrectNewsScreen({Key? key}) : super(key: key);

  static const routeName = '/correct-news';
  static const route = '/correct-news';

  @override
  _CorrectNewsScreenState createState() => _CorrectNewsScreenState();
}

class _CorrectNewsScreenState extends State<CorrectNewsScreen> {
  final GameController gc = Get.find();
  var barValue = 0.0;
  Timer? timer;

  @override
  initState() {
    super.initState();
    startTime();
    progressBarTimer();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    gc.game.nextRound();
    if (gc.game.isGameFinished()) {
      Get.offNamed(GameWinnerScreen.routeName);
    } else {
      Get.offNamed(ShowNewsScreen.routeName);
    }
  }

  progressBarTimer() async {
    timer = Timer.periodic(
        const Duration(milliseconds: 30), (_) => setProgressBarValue());
  }

  setProgressBarValue() {
    setState(() {
      if (barValue < 1) {
        barValue = barValue + 0.01;
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return WillPopScope(
      // This is short lived screen, let's block the back button
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Rodada ${gc.game.roundIndex + 1}/3',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: kYellow),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    LinearProgressIndicator(
                        minHeight: AppBar().preferredSize.height * 0.66,
                        value: barValue,
                        color: kPlayer_3),
                    Text('Link para a notícia real'),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1,
                      bottom: appBarHeight * 0.5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: appBarHeight * 0.26),
                            alignment: Alignment.center,
                            child: const Text('Noticia correta',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kYellow))),
                        ChatBalloon(
                            color: Colors.white,
                            balloonHeader: const Text('Você ouviu que ...',
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kGrayScaleDarkest)),
                            balloonText: RichText(
                                text: const TextSpan(
                                    text:
                                    'Lorem ipsum dolor sit amet, consectetur {RESPOSTA X} '
                                        'elit ut aliquam, purus sit amet luctus venenatis, lectus',
                                    style: TextStyle(
                                        height: 1.5,
                                        fontSize: 16,
                                        color: kGrayScaleDarkest)))),
                        Image(
                          alignment: Alignment.centerRight,
                          fit: BoxFit.contain,
                          image: Svg('assets/images/Person.svg',
                              size: Size(screenWidth * 0.30, screenWidth * 0.6)),
                        ),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}
