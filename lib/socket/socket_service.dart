import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConnection {
  static IO.Socket? socket;

  static void connectSocket(Function onConnect) {
    socket = IO.io(
        'http://139.59.37.47:3031/',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .enableForceNew() // disable auto-connection
            .build());
    socket!.connect();
    socket!.onConnect((_) {
      log('Location connected');
      onConnect();
    });

    socket?.onConnecting((data) => log("Location onConnecting $data"));
    socket?.onConnectError((data) => log("Location onConnectError $data"));
    socket?.onError((data) => log("Location onError $data"));
    socket?.onDisconnect((data) => log("Location onDisconnect $data"));
  }

  static void socketDisconnect() {
    socket?.onDisconnect((data) => log("Location onDisconnect $data"));
  }
}
