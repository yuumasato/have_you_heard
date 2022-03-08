import 'dart:convert';

import 'package:get/get.dart';
import 'package:have_you_heard/ui/desc_persona.dart';
import 'package:have_you_heard/ui/lobby.dart';
import 'package:have_you_heard/ui/room.dart';
import 'package:have_you_heard/ui/round_winner.dart';
import 'package:have_you_heard/ui/vote_answer.dart';
import 'package:have_you_heard/ui/vote_persona.dart';

import 'package:socket_io_client/socket_io_client.dart' as sio;

import 'package:have_you_heard/controller/game_controller.dart';

class Socket {
  sio.Socket socket = sio.io('https://haveyouheard.fun',
      sio.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build()
  );

  Socket() {
    initSocket();
  }

  void initSocket() {
    print('Init socket.');

    socket.on('chat message', (text) {
      print('Received: ' + text);
    });
    socket.onConnect((_) {
      print('connected to socket.io');
      final GameController gc = Get.find();
      gc.socket.initUser(gc.myPlayer.id);
    });
    socket.onDisconnect((_) {
      print('disconnected from socket.io');
    });
    socket.onError((data) {
      print('socket.io error:');
      print(data);
    });

    // We have received our own user id
    socket.on('user id', (data) {
      final GameController gc = Get.find();
      gc.myPlayer.id = data;
      gc.sendPlayerName();
      Future.delayed(const Duration(milliseconds: 80), () {
        // Workaround for Redis
        gc.sendLanguage();
      });
    });

    // We have just entered a room
    socket.on('room', (data) {
      final GameController gc = Get.find();
      var room = jsonDecode(data);
      String roomID = room['id'].substring(5);
      gc.roomID = roomID;
      gc.room.ownerID.value = room['ownerID'];

      gc.room.setUsers(room['users'], gc.myPlayer);

      String currentRoute = Get.currentRoute;
      if (currentRoute.startsWith('/lobby')) {
        // Only go to Room screen if current one is the Lobby
        Get.toNamed("${RoomScreen.route}/$roomID");
      }
    });

    socket.on('game', (data) {
      final GameController gc = Get.find();
      var game = jsonDecode(data);
      gc.game.setNews(game['headlines']);
      gc.game.setPlayers(game['players'], gc.myPlayer);

      // Navigation
      String currentRoute = Get.currentRoute;
      if (currentRoute.startsWith('/room')) {
          Get.offNamed(VotePersonaScreen.route);
      }

    });

    socket.on('persona', (data) {
      final GameController gc = Get.find();
      gc.game.persona = data;
      Get.offNamed(DescPersonaScreen.route);
    });

    socket.on('round answers', (data) {
      final GameController gc = Get.find();
      var answers = jsonDecode(data);
      gc.game.setAnswers(Map<String, String>.from(answers), gc.myPlayer);
      Get.offNamed(VoteAnswerScreen.route);
    });

    socket.on('round winner', (data) {
      final GameController gc = Get.find();
      gc.game.roundWinner = gc.game.getPlayerByID(data);
      Get.offNamed(RoundWinnerScreen.routeName);
    });

    socket.on('game winner', (data) {
      final GameController gc = Get.find();
      var winnerData = jsonDecode(data);

      gc.game.gameWinner = gc.game.getPlayerByID(winnerData['winner']);
      gc.game.setPlayerWins(Map<String, int>.from(winnerData['stats']));
      gc.game.tie = winnerData['tie'];
    });
  }

  void initUser(String userID) {
    if (userID == 'not_set') {
      socket.emit('user');
    } else {
      socket.emit('user', userID);
    }
  }
  void sendLang(String lang) {
    socket.emit('language', lang);
  }
  void sendName(String name) {
    socket.emit('name', name);
  }

  void createRoom() {
    socket.emit('new room');
  }

  void joinRoom(String roomID) {
    socket.emit('join', roomID);
  }

  void leaveRoom() {
    socket.emit('leave');
    Get.offAllNamed(LobbyScreen.route);
  }

  void rematch() {
    socket.emit('rematch');
  }

  void startGame() {
    socket.emit('start');
  }

  void votePersona(String persona) {
    socket.emit('vote persona', persona);
  }

  void sendAnswer(String answer) {
    socket.emit('answer', answer);
  }

  void voteAnswer(String id) {
    socket.emit('vote answer', id);
  }
}
