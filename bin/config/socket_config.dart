import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketConfig {
  io.Socket socket = io.io('http://localhost:8083', <String, dynamic>{
    'transports': ['websocket'],
  });

  Future<bool> initSocket() async {
    if (socket.connected) {
      try {
        socket.onConnect((_) {
          print('onConnect');
          socket.emit('isConnected', 'yes');
        });
        socket.on('connectionStatus', (_) => print('Result => $_'));
      } catch (e) {
        print(e.toString());
      }
      return true;
    } else {
      return false;
    }
  }

  Future<void> createOrderSend(dynamic data) async {
    try {
      socket.emit('createOrderSend', data);
      socket.on('createOrderResponse', (_) => print('Result => $_'));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateOrderSend(dynamic data) async {
    try {
      socket.emit('updateOrderSend', data);
      socket.on('updateOrderResponse', (_) => print('Result => $_'));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteOrderSend(dynamic data) async {
    try {
      socket.emit('deleteOrderSend', data);
      socket.on('deleteOrderResponse', (_) => print('Result => $_'));
    } catch (e) {
      print(e.toString());
    }
  }
}
