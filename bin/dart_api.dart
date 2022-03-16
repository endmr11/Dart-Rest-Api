import 'dart:async';

import 'package:alfred/alfred.dart';

import 'config/db_config.dart';
import 'controllers/controllers.dart';
import 'middlewares/middlewares.dart';

void main() async {
  final app = Alfred(onNotFound: missingHandler);
  final middlewares = Middlewares();
  final controllers = Controllers();
  final dbConfig = DbConfig();
  var dbConnection = await dbConfig.initDb();
  if (!dbConnection) app.close();

  app.post('/login', controllers.loginController, middleware: [middlewares.loginVerify]);

  app.get('/allOrders',controllers.allOrdersController,middleware: [middlewares.authenticationMiddleware]);

  await app.listen(8080);
}

FutureOr missingHandler(HttpRequest req, HttpResponse res) {
  res.statusCode = 404;
  return {'message': '404 not found'};
}
