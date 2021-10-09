import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'show_news.dart';


class DescPersonaScreen extends StatefulWidget {
  const DescPersonaScreen({Key? key}) : super(key: key);

  static const routeName = '/desc-persona';
  static const route = '/desc-persona';

  @override
  _DescPersonaScreenState createState() => _DescPersonaScreenState();
}

class _DescPersonaScreenState extends State<DescPersonaScreen> {

  @override
  initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Get.offNamed(ShowNewsScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // This is short lived screen, let's block the back button
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              Text('Coloque-se no papel de...'),
              Expanded(
                child: Text('Descrever personagem'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
