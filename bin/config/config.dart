import '../utils/app_utils.dart';
import 'app_config.dart';
import 'auth_config.dart';
import 'db_config.dart';

abstract class Config {
  final appConfig = AppConfig();
  final appUtils = AppUtils();
  final dbConfig = DbConfig();
  final jwtAuth = AuthConfig();

}