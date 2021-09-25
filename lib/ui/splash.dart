import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';

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
    Provider.of<HyhState>(context, listen:false).initSocket();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
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
            child: Center(
              child: Image.asset('assets/images/logo.png',
                  width: itemWidth, height: itemHeight),
            )
        )
    );
  }

}
