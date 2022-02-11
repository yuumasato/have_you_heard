import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/controller/setting_controller.dart';

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

  @override
  initState() {
    super.initState();
    final GameController gc = Get.find();
    gc.socket.initUser("");
    Future.delayed(const Duration(seconds: 4), () {
      showLang();
    });
  }

  showLang() {
    final GameController gc = Get.find();

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

  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
    final query = MediaQuery.of(context);
    final size = query.size;
    final logoWidth = size.width;
    final logoHeight = logoWidth * (size.width / size.height);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold, height: 1.25, fontFamily: 'Nunito'),
                children: [
                  TextSpan(text: 'HAVE YOU\n'),
                  TextSpan(text: 'HEARD?'),
                ],
              ),
            ),
            Hero(
              tag: 'logo',
              child: SizedBox(
                  height: logoHeight,
                  width: size.width,
                  child: SvgPicture.asset('assets/images/logo.svg')),
            ),
            Visibility(
              visible: isVisible,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Column(
                children: [
                  Text('Idioma'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 64,
                          icon: SvgPicture.asset('assets/images/flagArgentina.svg'),
                          onPressed: () async {
                            await setGameLanguage(gc, 'es');
                            route();
                          }),
                      IconButton(
                          iconSize: 64,
                          icon: SvgPicture.asset('assets/images/flagBrazil.svg'),
                          onPressed: () async {
                            await setGameLanguage(gc, 'pt');
                            route();
                          }),
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
