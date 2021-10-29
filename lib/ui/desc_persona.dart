import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/models/persona.dart';

import 'show_news.dart';

class DescPersonaScreen extends StatefulWidget {
  const DescPersonaScreen({Key? key}) : super(key: key);

  static const routeName = '/desc-persona';
  static const route = '/desc-persona';

  @override
  _DescPersonaScreenState createState() => _DescPersonaScreenState();
}

class _DescPersonaScreenState extends State<DescPersonaScreen> {
  var barValue = 0.0;
  Timer? timer;

  @override
  initState() {
    super.initState();
    startTime();
    progressBarTimer();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Get.offNamed(ShowNewsScreen.route);
  }

  progressBarTimer() async {
    timer = Timer.periodic(
        const Duration(milliseconds: 50), (_) => setProgressBarValue());
  }

  setProgressBarValue() {
    setState(() {
      if (barValue < 1) {
        barValue = barValue + 0.01;
      } else {
        timer!.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    final GameController gc = Get.find();
    Persona _persona = Persona.getPersona(gc.game.persona);

    return WillPopScope(
      // This is short lived screen, let's block the back button
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
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
                  Text('roleExplanation'.tr),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: appBarHeight * 0.53),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: appBarHeight * 0.5,
                      ),
                      child: Image(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.contain,
                        image: Svg(
                          _persona.svgAsset,
                          size: Size(128, 288),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.65,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kGrayScaleLight,
                        border:
                        Border.all(width: 4, color: kGrayScaleMediumLight),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: _persona.name,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: kGrayScaleDarkest)),
                                  const TextSpan(text: '\n \n'),
                                  TextSpan(
                                    text:
                                    _persona.desc,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                        color: Color(0xFF252C4A)),
                                    //TODO: Only use of this color, need confirmation from Design team
                                  ),
                                ])),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'characteristcs'.tr,
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                fontWeight: FontWeight.bold,
                                                color: kGrayScaleDarkest)),
                                        TextSpan(
                                            text:
                                            '• '+_persona.personality.join('\n• '),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                height: 1.5,
                                                color: Color(0xFF252C4A))),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: false, // Topics will be disabled for now
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'topics'.tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: kGrayScaleDarkest)),
                                          TextSpan(
                                              text:
                                              '• '+_persona.topics.join('\n• '),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5,
                                                  color: Color(0xFF252C4A))),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
