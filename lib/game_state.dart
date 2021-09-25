import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as sio;

class GameState extends ChangeNotifier {
  List<String> allNews = [
    'Pergunta 1',
    'Pergunta 2',
    'Pergunta 3',
  ];
  int roundIndex = 0;

  List<String> allPlayers = [
    'Nickname 1',
    'Nickname 2',
    'Nickname 3',
    'Nickname 4',
    'Nickname 5',
    'Nickname 6',
  ];

  void bumpRound() {
    roundIndex += 1;
    notifyListeners();
  }

  void reset() {
    roundIndex = 0;
    notifyListeners();
  }
}

class HyhState extends ChangeNotifier {
  // Declare Socket
  sio.Socket socket = sio.io('https://my-echo-chat.herokuapp.com',
      sio.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build()
  );
  Color socketColor = Colors.red;
  bool _onboarded = false;
  int roomID = 42069;

  Future<bool?> getOnboardedState() async {
    final prefs = await SharedPreferences.getInstance();
    _onboarded = prefs.getBool('onBoarded') ?? false;
  }

  void initSocket() {
    socket.on('chat message', (text) {
      print('Receiving: ' + text);
    });
    socket.onConnect((_) {
      socketColor = Colors.green;
      print('connected to socket.io');
      notifyListeners();
    });
    socket.onDisconnect((_) {
      socketColor = Colors.red;
      print('disconnected from socket.io');
      notifyListeners();
    });
    print('Connecting to chat service');
  }
}