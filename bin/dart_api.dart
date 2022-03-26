import 'dart:async';

import 'package:alfred/alfred.dart';

import 'config/db_config.dart';
import 'config/socket_config.dart';
import 'controllers/controllers.dart';
import 'middlewares/middlewares.dart';

void main() async {
  final app = Alfred(onNotFound: missingHandler);
  final middlewares = Middlewares();
  final controllers = Controllers();
  final dbConfig = DbConfig();
  final socketConfig = SocketConfig();
  var dbConnection = await dbConfig.initDb();
  await socketConfig.initSocket();

  //LOGIN
  app.post('/login', controllers.loginControllers.loginController, middleware: [middlewares.loginMiddlewares.loginVerify]);
  app.post('/refresh/token', controllers.loginControllers.refreshController);
  //ORDERS
  app.all('/orders/*', (req, res) => null, middleware: [middlewares.authMiddlewares.authenticationMiddleware]);
  app.get('/orders/all-orders', controllers.ordersControllers.allOrdersController);
  app.get('/orders/order/:id', controllers.ordersControllers.orderController);
  app.get('/orders/my-orders/:id',controllers.ordersControllers.myOrderController);
  app.post('/orders/order-create', controllers.ordersControllers.orderCreateController);
  app.put('/orders/order-update/:id', controllers.ordersControllers.orderUpdateController);
  app.get('/orders/order-delete/:id', controllers.ordersControllers.orderDeleteController);

  //PRODUCTS
  app.all('/products/*', (req, res) => null, middleware: [middlewares.authMiddlewares.authenticationMiddleware]);
  app.get('/products/all-products', controllers.productControllers.allProductsController);
  app.get('/products/product/:id', controllers.productControllers.productController);

  //USER
  app.all('/users/*', (req, res) => null, middleware: [middlewares.authMiddlewares.authenticationMiddleware]);
  app.get('/users/user/:id', controllers.userControllers.userController);
  if (dbConnection) await app.listen(8080);
}

FutureOr missingHandler(HttpRequest req, HttpResponse res) {
  res.statusCode = 404;
  return {'message': '404 not found'};
}
