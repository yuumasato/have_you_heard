import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'package:have_you_heard/ui/settings.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  static const routeName = '/lobby';
  static const route = '/lobby';

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final myController = TextEditingController();

  final appBar = AppBar(
    backgroundColor: kBackgroundDarkestGray,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        icon: Icon(Icons.settings_outlined),
      onPressed: () {
          Get.toNamed(SettingsScreen.route);
      }),
    ]
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
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Sair do jogo?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Continuar jogando')),
                    TextButton(
                        onPressed: () =>SystemNavigator.pop(),
                        child: const Text('Fechar'))
                  ],
                ));
        return false;
      },
      child: Scaffold(
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
                  'Escolha seu modo de jogo, ${gc.myPlayer.name}!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Expanded(
                flex:3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 38,
                            width: 200.0,
                            child: TextField(
                                controller: myController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelText: 'Insira o código da sala',
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
                            style: ElevatedButton.styleFrom(primary:kYellowButton),
                            onPressed: () {
                              gc.roomID = int.parse(myController.text);
                              gc.joinRoom(gc.roomID);
                            },
                            child:
                            Text(
                              'entrar'.tr,
                              style: const TextStyle(fontSize: 16, color: kBackgroundDarkestGray),
                            )),
                      ],
                    ),
                    Container(
                      width: 200,
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 50,
                              child: const Divider(
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'ou',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Container(
                              width: 50,
                              child: const Divider(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary:kYellowButton),
                        onPressed: () {
                          // Requisitar ao servidor criação de nova sala
                          gc.createRoom();
                        },
                        child:
                        Text(
                          'criarSala'.tr,
                          style: const TextStyle(fontSize: 16, color: kBackgroundDarkestGray),
                        )),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: Svg("assets/images/full_landscape.svg",
                            size: Size(375, 182)),
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
