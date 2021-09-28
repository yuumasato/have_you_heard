import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';
var isVisible = false;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Provider.of<HyhState>(context, listen: false).initSocket();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, showLang());
  }

  showLang() {
     isVisible = !isVisible;
  }


  route() {
    Navigator.pushReplacementNamed(context, '/lobby');
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final itemWidth = size.width;
    final itemHeight = itemWidth * (size.width / size.height);
    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Have you heard?'),
                  Image.asset('assets/images/logo.png',
                  width: itemWidth, height: itemHeight),
                  Visibility(
                    visible: isVisible,
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
