import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import 'set_user_name.dart';
import 'lobby.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static const routeName = '/onboarding-1';
  static const route = '/onboarding-1';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final mediaWidth = size.width;
    final mediaHeight = size.height;
    final logoHeight = mediaWidth * (mediaWidth / mediaHeight);
    final mediaTopPadding = query.padding.top;
    final mediaViewHeight = mediaHeight - mediaTopPadding;
    final personaWidth = mediaWidth / 8;
    final _currentPageNotifier = ValueNotifier<int>(0);
    final PageController controller = PageController(initialPage: 0);
    return Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            },
            children: [
              pageBuilder(
                const Text('Você ouviu que...',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.5)),
                RichText(
                    text: const TextSpan(
                        text: '"Have you Heard?" É um jogo multiplayer para conscientizar sobre fake news.',
                        style: TextStyle(fontSize: 16.0, height: 1.5))),
                Hero(
                    tag: 'logo',
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 47),
                        alignment: Alignment.topRight,
                        height: logoHeight,
                        width: size.width,
                        child: SvgPicture.asset('assets/images/logo.svg',
                            width: mediaWidth / 3))),
              ),
              pageBuilder(
                  const Text('Personagem',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.5)),
                  RichText(
                      text: const TextSpan(
                          text: 'Coloque-se no papel de um personagem e faça sua melhor imitação.',
                          style: TextStyle(fontSize: 16.0, height: 1.5))),
                  SizedBox(
                      height: 300,
                      width: mediaWidth,
                      child: personaStack(personaWidth))),
              pageBuilder(
                  const Text('Rodadas',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.5)),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(fontSize: 16.0, height: 1.5),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Seja rápido e convincente para aumentar suas chances de '),
                            TextSpan(
                                text: 'ganhar uma viagem espacial',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough)),
                            TextSpan(
                                text: ' vencer!')
                          ])),
                  Stack(clipBehavior: Clip.none, children: [
                    SizedBox(
                        width: mediaWidth,
                        child: SvgPicture.asset('assets/images/carWithLulo.svg',
                            width: size.width)),
                    Positioned(
                        bottom: -15.0,
                        left: mediaWidth / 2 - mediaWidth / 6,
                        child: SizedBox(
                            width: mediaWidth / 3,
                            height: 48,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(UserNameScreen.route);
                                },
                                child: const Text(
                                  'Continuar',
                                ))))
                  ])),
            ],
          ),
          Positioned(
              left: 0.0,
              right: 0.0,
              bottom:  80.0,
              child: CirclePageIndicator(
                size: 10.0,
                selectedSize: 12.0,
                itemCount: 3,
                currentPageNotifier: _currentPageNotifier,
              )
          ),
        ]
    );
  }

  Widget personaStack(double bodySpacing) {
    final spacingFactor = 1.25;
    final personaRenderWidth = bodySpacing * spacingFactor;
    final leftOffset = 5.0;
    return Stack(children: [
      Positioned(
          left: -leftOffset,
          child: SvgPicture.asset('assets/images/bodySalvio.svg',
              width: personaRenderWidth)),
      Positioned(
          left: bodySpacing - leftOffset,
          child: SvgPicture.asset('assets/images/bodyLulo.svg',
              width: personaRenderWidth)),
      Positioned(
          left: bodySpacing * 2 - leftOffset,
          child: SvgPicture.asset('assets/images/bodyAntivax.svg',
              width: personaRenderWidth)),
      Positioned(
          left: bodySpacing * 3 - leftOffset,
          child: SvgPicture.asset('assets/images/bodyVegan.svg',
              width: personaRenderWidth)),
      Positioned(
          left: bodySpacing * 4 - leftOffset,
          child: SvgPicture.asset('assets/images/bodyTump.svg',
              width: personaRenderWidth)),
      Positioned(
          left: bodySpacing * 5 - leftOffset,
          child: SvgPicture.asset('assets/images/bodyBonosaro.svg',
              width: personaRenderWidth)),
      Positioned(
          left: bodySpacing * 6 - leftOffset,
          child: SvgPicture.asset('assets/images/bodyEronMust.svg',
              width: personaRenderWidth)),
      Positioned(
          left: bodySpacing * 7 - leftOffset,
          child: SvgPicture.asset('assets/images/bodyTiaDoZap.svg',
              width: personaRenderWidth)),
    ]);
  }

  Widget pageBuilder(Text balloonHeader, RichText balloonText, Widget illustration) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final mediaHeight = size.height;
    final mediaTopPadding = query.padding.top;
    final mediaViewHeight = mediaHeight - mediaTopPadding;

    return Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 47),
                    height: (mediaViewHeight) / 2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ChatBalloon(
                        balloonHeader: balloonHeader,
                        balloonText: balloonText,
                      ),
                    )),
                illustration
              ],
            )));
  }
}
