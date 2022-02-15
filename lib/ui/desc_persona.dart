import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/constants/styles.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/models/persona.dart';
import 'package:have_you_heard/widgets/in_game_app_bar.dart';

import 'show_rounds.dart';

class DescPersonaScreen extends StatefulWidget {
  const DescPersonaScreen({Key? key}) : super(key: key);

  static const routeName = '/desc-persona';
  static const route = '/desc-persona';

  @override
  _DescPersonaScreenState createState() => _DescPersonaScreenState();
}

class _DescPersonaScreenState extends State<DescPersonaScreen>
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

  @override
  initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });

    Future.delayed(_screenDuration, () {
      setState(() {
        Get.offNamed(ShowRoundsScreen.route);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final scaleFactor = screenHeight/667;
    final appBarHeight = AppBar().preferredSize.height;

    final GameController gc = Get.find();
    Persona _persona = Persona.getPersona(gc.game.persona);

    return WillPopScope(
      // This is short lived screen, let's block the back button
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const InGameAppBar(),
        body: SafeArea(
          child: Column(
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
                  Text('roleExplanation'.tr, style: HyhTextStyle.heading18Bold,),
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
                        height: 215*scaleFactor,
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.contain,
                        image: Svg(
                          _persona.svgAsset,
                          size: const Size(128, 288),
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
                                textScaleFactor: scaleFactor,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: _persona.name,
                                      style: HyhTextStyle.heading24Height15BoldDarkest),
                                  const TextSpan(text: '\n'),
                                  TextSpan(
                                    text:
                                    _persona.desc,
                                    style: HyhTextStyle.body14Height15Darkest),
                                ])),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    textScaleFactor: scaleFactor,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'characteristcs'.tr,
                                            style: HyhTextStyle.body16Height15BoldDarkest),
                                        TextSpan(
                                            text:
                                            '• '+_persona.personality.join('\n• '),
                                            style: HyhTextStyle.body14Height15Darkest),
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
