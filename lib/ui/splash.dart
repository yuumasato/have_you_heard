import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'lobby.dart';

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
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, showLang);
  }

  showLang() {
    setState(() {
      isVisible = !isVisible;
    });
  }


  route() {
    Get.offNamed(LobbyScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
                  Text('Have you heard?'),
                  Container(
                      height: logoHeight,
                      width: size.width,
                      child: SvgPicture.asset('assets/images/logo.svg')
                  ),
                  Visibility(
                    visible: isVisible,
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            var locale = Locale('es', 'AR');
                            Get.updateLocale(locale);
                            route();
                          },
                          child: const Text('AR')),
                        ElevatedButton(
                          onPressed: () {
                            var locale = Locale('pt', 'BR');
                            Get.updateLocale(locale);
                            route();
                          },
                          child: const Text('PT')),
                      ],
                    ),
                  ),
                ],
            ),
        ),
    );
  }
}
