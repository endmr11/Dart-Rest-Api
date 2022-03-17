import '../utils/app_utils.dart';
import 'auth_config.dart';
import 'db_config.dart';

abstract class Config {
  final appUtils = AppUtils();
  final dbConfig = DbConfig();
  final jwtAuth = AuthConfig();
}
