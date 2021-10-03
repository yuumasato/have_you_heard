import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'lobby.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({Key? key}) : super(key: key);

  static const routeName = '/get-user-name';
  static const route = '/get-user-name';

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final myController = TextEditingController();
  final appBar = AppBar(
    backgroundColor: kBackgroundDarkestGray,
    automaticallyImplyLeading: false,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
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
              child: const Text(
                'Escolha seu nome no jogo',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 38,
            ),
            Expanded(
              flex:3,
              child: Column(
                children: [
                  const Text('Como você quer ser chamado?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        height: 38,
                        width: 200.0,
                        child: TextField(
                          controller: myController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Insira seu nome',
                            labelStyle: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w300),
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.red,
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white, decoration: TextDecoration.none),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            String username = myController.text;
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('username', username);
                            gc.username = username;

                            Get.toNamed(LobbyScreen.route);
                          },
                          child:
                          Text(
                            'entrar'.tr,
                            style: const TextStyle(fontSize: 16, color: kBackgroundDarkestGray),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                height: 182,
                decoration: const BoxDecoration(
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