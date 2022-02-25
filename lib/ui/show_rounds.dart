import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/ui/show_news.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';

class ShowRoundsScreen extends StatefulWidget {
  const ShowRoundsScreen({Key? key}) : super(key: key);

  static const routeName = '/show-round';
  static const route = '/show-round';

  @override
  _ShowRoundsScreenState createState() => _ShowRoundsScreenState();
}

class _ShowRoundsScreenState extends State<ShowRoundsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 7),
    vsync: this,
  )..forward();

  late final Animation<double> _progressBarValue = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear)
  );

  bool _balloonFirstState = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });

    Future.delayed(const Duration(milliseconds: 1700), () {
      setState(() {
        _balloonFirstState = false;
      });
    });

    Future.delayed(const Duration(seconds: 7), () {
      Get.offNamed(ShowNewsScreen.route);
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
    final GameController gc = Get.find();

    const int carWidth = 602;
    const int carHeight = 351;
    double wRatio;
    wRatio = (screenWidth/carWidth)*1.05;
    double windShieldRatio = 0.73;

    ChatBalloon roundBanner = ChatBalloon(
      balloonHeader:const Text(
        '',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      balloonText:  RichText(
          text: TextSpan(
              text: 'showRound'.trParams({'round': '${gc.game.roundIndex + 1}'}),
              style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: kYellow,
                  fontSize: 32.0,
                  height: 2
              )
          )
      ),
    );

    ChatBalloon roundNews = ChatBalloon(
      balloonHeader:Text(
        'haveYouHeard...'.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      balloonText:  RichText(
          text: TextSpan(
              text: gc.game.getBlankHeadline(),
              style: const TextStyle(
                  fontSize: 16.0,
                  height: 1.5
              )
          )
      ),
    );

    return GameExitDialog (
      onElevatedPressed: () => Navigator.of(context).pop(),
      onPlainPressed: () => gc.exitGame(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'showRound'.trParams({'round': '${gc.game.roundIndex + 1}'}),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: kYellow),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    LinearProgressIndicator(
                      minHeight: AppBar().preferredSize.height * 0.66,
                      value: _progressBarValue.value,
                      color: kPlayer_3,
                      backgroundColor: kGrayScaleMediumDark,
                    ),
                    Text('')
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: AnimatedCrossFade(
                    crossFadeState: _balloonFirstState ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 500),
                    firstChild: roundBanner,
                    secondChild: roundNews,
                  ),
                ),
                Stack(
                    children: [
                      Positioned(
                        left:  screenWidth/2 - (carWidth*wRatio*windShieldRatio)/2,
                        top: carHeight*wRatio/4.4*-1,
                        child: Image(
                          fit: BoxFit.fitHeight,
                          image: Svg(
                            'assets/images/frontview_'+ gc.game.persona.replaceAll(' ', '') +'.svg',
                            size: Size(carWidth*wRatio*windShieldRatio, carHeight*wRatio),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: carHeight*wRatio,
                          child: OverflowBox(
                            child: Image(
                              fit: BoxFit.fitHeight,
                              image: Svg(
                                'assets/images/car_frontview_empty.svg',
                                size: Size(carWidth*wRatio, carHeight*wRatio),
                              ),
                            ),
                          )
                      ),
                    ]),
                Spacer(),
              ],
            )),
      ),
    );
  }
}
