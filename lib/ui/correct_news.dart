import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/widgets/in_game_app_bar.dart';

import 'game_winner.dart';
import 'show_rounds.dart';

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

class _CorrectNewsScreenState extends State<CorrectNewsScreen>
    with SingleTickerProviderStateMixin {
  final Duration _screenDuration = const Duration(seconds: 6);

  late final AnimationController _controller = AnimationController(
    duration: _screenDuration,
    vsync: this,
  )..forward();

  late final Animation<double> _progressBar = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear)
  );

  final GameController gc = Get.find();

  @override
  initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });

    Future.delayed(_screenDuration, () {
      gc.game.nextRound();
      if (gc.game.isGameFinished()) {
        Get.offNamed(GameWinnerScreen.routeName);
      } else {
        Get.offNamed(ShowRoundsScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return WillPopScope(
      // This is short lived screen, let's block the back button
      onWillPop: () async => false,
      child: Scaffold(
        appBar: InGameAppBar(
          title:
            'showRound'.trParams({'round': '${gc.game.roundIndex + 1}'}),
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
                        value: _progressBar.value,
                        color: kPlayer_3,
                        backgroundColor: kGrayScaleMediumDark),
                    Text('newsLink'.tr),
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
                            child: Text('correctNews'.tr,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kYellow))),
                        ChatBalloon(
                            color: Colors.white,
                            balloonHeader: Text('actuallySaid'.tr,
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kGrayScaleDarkest)),
                            balloonText: RichText(
                                text:  TextSpan(
                                    text: gc.game.getCorrectHeadline(),
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
