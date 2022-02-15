import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/styles.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'lobby.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/splash';
  static const route = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isVisible = false;
  final GameController gc = Get.find();

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      showLang();
    });
    gc.getOnboardedState();
  }

  showLang() {
    if (gc.onBoarded) {
      Get.offNamed(LobbyScreen.route);
    } else {
      setState(() {
        isVisible = !isVisible;
      });
    }
  }


  route() {
    final GameController gc = Get.find();
    if (gc.onBoarded) {
      Get.offNamed(LobbyScreen.route);
    } else {
      Get.toNamed(OnboardingScreen.route);
    }
  }

  double getLogoSize(Size screenSize){
    double minSize;
    if(screenSize.height*0.35>screenSize.width*0.62){
      minSize = screenSize.width*0.62;
    } else {
      minSize = screenSize.height*0.35;
    }
    return minSize;
  }

  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
    final query = MediaQuery.of(context);
    final size = query.size;
    final logoHeight = getLogoSize(size);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: logoHeight*0.35,
              child: FittedBox(
                fit: BoxFit.contain,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: HyhTextStyle.heading32Bold,
                    children: [
                      TextSpan(text: 'HAVE YOU\n'),
                      TextSpan(text: 'HEARD?'),
                    ],
                  ),
                ),
              ),
            ),
            Hero(
              tag: 'logo',
              child: SizedBox(
                  height: logoHeight,
                  width: logoHeight,
                  child: SvgPicture.asset('assets/images/logo.svg')),
            ),
            Visibility(
              visible: isVisible,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Column(
                children: [
                  SizedBox(
                    height: logoHeight*0.105,
                    child: const FittedBox(
                      fit: BoxFit.contain,
                        child: Text('Idioma',style: HyhTextStyle.heading18Bold,)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:logoHeight*0.27,
                        child: FittedBox(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.contain,
                          child: IconButton(
                              iconSize: 64,
                              icon: SvgPicture.asset('assets/images/flagArgentina.svg'),
                              onPressed: () {
                                gc.setLanguage('es');
                                route();
                              }),
                        ),
                      ),
                      SizedBox(
                        height:logoHeight*0.27,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: IconButton(
                              iconSize: 64,
                              icon: SvgPicture.asset('assets/images/flagBrazil.svg'),
                              onPressed: () {
                                gc.setLanguage('pt');
                                route();
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
