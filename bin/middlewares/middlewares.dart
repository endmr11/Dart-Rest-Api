import 'auth_middlewares/auth_middlewares.dart';
import 'login_middlewares/login_middlewares.dart';

class Middlewares {
//LOGIN
  final loginMiddlewares = LoginMiddlewares();
//AUTH
  final authMiddlewares = AuthMiddlewares();
}
