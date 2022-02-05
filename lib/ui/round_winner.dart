import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/models/player.dart';
import 'package:have_you_heard/widgets/in_game_app_bar.dart';
import 'correct_news.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';

class RoundWinnerScreen extends StatefulWidget {
  const RoundWinnerScreen({Key? key}) : super(key: key);

  static const routeName = '/round-winner';
  static const route = '/round-winner';

  @override
  _RoundWinnerScreenState createState() => _RoundWinnerScreenState();
}

class _RoundWinnerScreenState extends State<RoundWinnerScreen>
    with SingleTickerProviderStateMixin {
  final Duration _screenDuration = const Duration(seconds: 5);

  late final AnimationController _controller = AnimationController(
    duration: _screenDuration,
    vsync: this,
  )..forward();

  late final Animation<double> _progressBar = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear)
  );

  initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });

    Future.delayed(_screenDuration, () {
      Get.offNamed(CorrectNewsScreen.routeName);
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
    final GameController gc = Get.find();
    Player _winner = gc.game.roundWinner ?? Player();

    return WillPopScope(
      // This is short lived screen, let's block the back button
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const InGameAppBar(),
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
                      child: Text(
                        _winner.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kYellow,
                        ),
                      ),
                    ),
                    ChatBalloon(
                        balloonHeader: Text('haveYouHeard...'.tr,
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
