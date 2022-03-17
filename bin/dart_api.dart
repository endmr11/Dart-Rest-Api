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

  //LOGIN
  app.post('/login', controllers.loginController, middleware: [middlewares.loginVerify]);
  //ORDERS
  app.get('/all-orders', controllers.allOrdersController, middleware: [middlewares.authenticationMiddleware]);
  app.get('/order/:id', controllers.orderController, middleware: [middlewares.authenticationMiddleware]);
  app.post('/order-edit/:id', controllers.orderEditController, middleware: [middlewares.authenticationMiddleware]);
  app.get('/order-delete/:id', controllers.orderDeleteController, middleware: [middlewares.authenticationMiddleware]);
  app.post('/order-create', controllers.orderCreateController, middleware: [middlewares.authenticationMiddleware]);
  //PRODUCTS
  app.get('/all-products', controllers.allProductsController, middleware: [middlewares.authenticationMiddleware]);
  app.get('/product/:id', controllers.productController, middleware: [middlewares.authenticationMiddleware]);

  await app.listen(8080);
}

FutureOr missingHandler(HttpRequest req, HttpResponse res) {
  res.statusCode = 404;
  return {'message': '404 not found'};
}
