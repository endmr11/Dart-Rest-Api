import '../utils/response_handler.dart';
import 'auth_config.dart';
import 'db_config.dart';
import 'socket_config.dart';

abstract class Config with ResponseHandler {

  final dbConfig = DbConfig();
  final jwtAuth = AuthConfig();
  final socketConfig = SocketConfig();
}
