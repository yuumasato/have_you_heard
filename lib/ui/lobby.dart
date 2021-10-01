import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';

import 'package:have_you_heard/game_state.dart';
import 'package:have_you_heard/ui/room.dart';
import 'package:provider/provider.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  static const routeName = '/lobby';

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
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
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: const Text('Sair do jogo')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Continuar jogando'))
                  ],
                ));
        return false;
      },
      child: Scaffold(
        backgroundColor: kBackgroundDarkestGray,
        appBar: appBar,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: (screenHeight - appBarHeight - statusBarHeight) * 0.07,
                color: kBackgroundDarkGray,
                alignment: Alignment.center,
                child: const Text(
                  'Escolha seu modo de jogo',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Consumer<HyhState> (
                  builder: (context, hyh, child) {
                    return Row(
                        children: [
                          const Text('Lobby'
                          ),
                          Icon(Icons.network_check,color: hyh.socketColor, size: 20.0),
                        ]
                    );
                  }
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
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Insira o código da sala',
                                  labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                                ))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(primary:kYellowButton),
                            onPressed: () {
                              String roomID = myController.text;
                              Provider.of<HyhState>(context, listen: false).roomID =
                                  int.parse(roomID);
                              Navigator.pushNamed(context, RoomScreen.routeName,
                                  arguments: roomID);
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
                          // TODO: criar GameState e passar pra RoomScreen
                          String roomID =
                          Provider.of<HyhState>(context, listen: false)
                              .roomID
                              .toString();
                          Navigator.pushNamed(context, RoomScreen.routeName,
                              arguments: roomID);
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
                        image: AssetImage("assets/images/full_landscape.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
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
