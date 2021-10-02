import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'game_winner.dart';
import 'show_news.dart';

class CorrectNewsScreen extends StatefulWidget {
  const CorrectNewsScreen({Key? key}) : super(key: key);

  static const routeName = '/correct-news';
  static const route = '/correct-news';

  @override
  _CorrectNewsScreenState createState() => _CorrectNewsScreenState();
}

class _CorrectNewsScreenState extends State<CorrectNewsScreen> {
  @override
  initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    final GameController gc = Get.find();
    gc.nextRound();
    if (gc.isGameFinished()) {
      Get.offNamed(GameWinnerScreen.routeName);
    } else {
      Get.offNamed(ShowNewsScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Text('Link para a notícia real'),
            Text('Noticia correta'),
            Text('Lorem ipsum dolor sit amet, consectetur {RESPOSTA X} '
                'elit ut aliquam, purus sit amet luctus venenatis, lectus'),
          ],
        ),
      ),
    );
  }
}
