import 'package:socket_io_client/socket_io_client.dart' as sio;

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
      print('Receiving: ' + text);
    });
    socket.onConnect((_) {
      print('connected to socket.io');
    });
    socket.onDisconnect((_) {
      print('disconnected from socket.io');
    });
  }
}
