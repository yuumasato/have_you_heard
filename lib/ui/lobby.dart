import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    return WillPopScope (
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
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
        body: SafeArea(
          child: Column(
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 200.0,
                      height: 38.0,
                      child: TextField(
                          controller: myController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Insira o código da sala',
                          ))
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String roomID = myController.text;
                        Provider.of<HyhState>(context, listen: false).roomID = int.parse(roomID);
                        Navigator.pushNamed(context, RoomScreen.routeName, arguments: roomID);
                      },
                      child: Text('entrar'.tr)),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    // Requisitar ao servidor criação de nova sala
                    // TODO: criar GameState e passar pra RoomScreen
                    String roomID = Provider.of<HyhState>(context, listen: false).roomID.toString();
                    Navigator.pushNamed(context, RoomScreen.routeName, arguments: roomID);
                  },
                  child: Text('criarSala'.tr)),
            ],
          ),
        ),
      ),
    );
  }
}