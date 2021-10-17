import 'dart:convert';

import 'package:get/get.dart';
import 'package:have_you_heard/ui/desc_persona.dart';
import 'package:have_you_heard/ui/lobby.dart';
import 'package:have_you_heard/ui/room.dart';
import 'package:have_you_heard/ui/vote_persona.dart';

import 'package:socket_io_client/socket_io_client.dart' as sio;

import 'package:have_you_heard/controller/game_controller.dart';

class Socket {
  sio.Socket socket = sio.io('https://my-echo-chat.herokuapp.com',
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

      socket.emit('name', gc.myPlayer.name);
      //TODO Send the language when the server supports it
    });

    // We have just entered a room
    socket.on('room', (data) {
      final GameController gc = Get.find();
      var room = jsonDecode(data);
      String roomID = room['id'].substring(5);
      gc.roomID = roomID;
      gc.room.ownerID.value = room['ownerID'];

      gc.room.setUsers(room['users'], gc.myPlayer);
      Get.toNamed("${RoomScreen.route}/$roomID");
    });

    socket.on('game', (data) {
      final GameController gc = Get.find();
      var game = jsonDecode(data);
      gc.game.setHeadlines(List<String>.from(game['headlines']));
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
  }

  void initUser(String username) {
    socket.emit('user');
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

  void startGame() {
    socket.emit('start');
  }

  void votePersona(String persona) {
    socket.emit('vote persona', persona);
  }
}
