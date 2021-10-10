import 'dart:convert';

import 'package:get/get.dart';
import 'package:have_you_heard/ui/lobby.dart';
import 'package:have_you_heard/ui/room.dart';
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
      gc.game.ownerID.value = room['ownerID'];

      gc.game.setPlayers(room['users'], gc.myPlayer);
      Get.toNamed("${RoomScreen.route}/$roomID");
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
}
