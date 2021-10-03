import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';
  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();

    final appBar = AppBar(
      backgroundColor: kBackgroundDarkestGray,
      automaticallyImplyLeading: false,
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = appBar.preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;


    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom:20),
              height: (screenHeight - appBarHeight - statusBarHeight) * 0.07,
              color: kBackgroundDarkGray,
              alignment: Alignment.center,
              child: Text(
                'Configurações',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 42),
                child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('username');
                      await prefs.remove('locale');
                      final snackBar = SnackBar(
                        content: const Text('Configurações excluídas'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text('Limpar configurações')
                )
            ),
            Expanded(
              child: Container(
                height: 100,
              ),
            ),
            Container(
              height: 182,
              decoration:  const BoxDecoration(
                image: DecorationImage(
                  image: Svg("assets/images/full_landscape.svg",
                      size: Size(375, 182)),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
