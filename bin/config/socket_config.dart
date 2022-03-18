import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketConfig {
  static io.Socket socket = io.io('http://localhost:8083', <String, dynamic>{
    'transports': ['websocket'],
  });

  Future<void> initSocket() async {
    socket.onConnect((_) {
      print('onConnect');
      socket.emit('isConnected', 'yes');
    });
    socket.on('connectionStatus', (_) => print('Result => $_'));
  }

  Future<void> createOrderSend(dynamic data) async {
    socket.emit('createOrderSend', data);
    socket.on('createOrderResponse', (_) => print('Result => $_'));
  }

  Future<void> updateOrderSend(dynamic data) async {
    socket.emit('updateOrderSend', data);
    socket.on('updateOrderResponse', (_) => print('Result => $_'));
  }

  Future<void> deleteOrderSend(dynamic data) async {
    socket.emit('deleteOrderSend', data);
    socket.on('deleteOrderResponse', (_) => print('Result => $_'));
  }
}
