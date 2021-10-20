import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'correct_news.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';

class RoundWinnerScreen extends StatefulWidget {
  const RoundWinnerScreen({Key? key}) : super(key: key);

  static const routeName = '/round-winner';
  static const route = '/round-winner';

  @override
  _RoundWinnerScreenState createState() => _RoundWinnerScreenState();
}

class _RoundWinnerScreenState extends State<RoundWinnerScreen> {
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
    Get.offNamed(CorrectNewsScreen.routeName);
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
    final GameController gc = Get.find();

    return WillPopScope(
      // This is short lived screen, let's block the back button
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
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
                    color: kPlayer_3,
                    backgroundColor: kGrayScaleMediumDark,
                  ),
                  Text('roundWinner'.tr),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1,
                  bottom: appBarHeight * 0.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: appBarHeight * 0.26),
                      alignment: Alignment.center,
                      child: const Text(
                        "Nome do jogador",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kYellow,
                        ),
                      ),
                    ),
                    ChatBalloon(
                        balloonHeader: const Text('Você ouviu que ...',
                            style: TextStyle(
                                height: 1.5,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        balloonText: RichText(
                            text:  TextSpan(
                                text: gc.game.getWinnerHeadline(),
                                style: TextStyle(height: 1.5, fontSize: 16)))),
                    Image(
                      alignment: Alignment.centerRight,
                      fit: BoxFit.contain,
                      image: Svg(
                        'assets/images/bodyAntivax.svg',
                        size: Size(screenWidth * 0.30, screenWidth * 0.6),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
