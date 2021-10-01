import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'correct_news.dart';

class RoundWinnerScreen extends StatefulWidget {
  const RoundWinnerScreen({Key? key}) : super(key: key);

  static const routeName = '/round-winner';
  static const route = '/round-winner';

  @override
  _RoundWinnerScreenState createState() => _RoundWinnerScreenState();
}

class _RoundWinnerScreenState extends State<RoundWinnerScreen> {
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
    Get.offNamed(CorrectNewsScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Text('Vencedor da Rodada'),
            Text('Lorem ipsum dolor sit amet, consectetur {RESPOSTA X} '
                'elit ut aliquam, purus sit amet luctus venenatis, lectus'),
          ],
        ),
      ),
    );
  }
}
