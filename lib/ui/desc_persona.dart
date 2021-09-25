import 'dart:async';

import 'package:flutter/material.dart';

class DescPersonaScreen extends StatefulWidget {
  const DescPersonaScreen({Key? key}) : super(key: key);

  static const routeName = '/desc-persona';

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
    Navigator.pushReplacementNamed(context, '/question');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
