import 'dart:convert';

import 'package:alfred/alfred.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../config/config.dart';

class Controllers extends Config {
  //LOGIN
  loginController(HttpRequest req, HttpResponse res) async {
    print("Controller: loginController start");
    final body = await req.bodyAsJsonMap;

    try {
      jwtAuth.setJwtPayload(body['email'], body['password']);
      final token = jwtAuth.myJwt.sign(SecretKey(jwtAuth.secretKey), expiresIn: Duration(minutes: 3));
      final userInfo = await dbConfig.getUserInfo(body['email']);
      List<Map<String, dynamic>> model = [];

      for (final element in userInfo) {
        Map<String, dynamic> modelMap = {
          "id": element[0],
          "name": element[1],
          "surname": element[2],
          "email": element[3],
          "token": token,
          "userGroup": element[5],
        };
        model.add(modelMap);
      }

      final responseMap = appUtils.generateOkResMap(model);
      res.send(jsonEncode(responseMap));
    } catch (e) {
      final responseMap = appUtils.generateErrorResMap(e.toString());
      res.send(jsonEncode(responseMap));
    }
  }

  //ORDERS
  allOrdersController(HttpRequest req, HttpResponse res) async {
    print("Controller: allOrdersController start");
    var response = await dbConfig.testDb();
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'order_id': element[0], 'user_id': element[1], 'products': element[2]};
      model.add(modelMap);
    }
    final responseMap = appUtils.generateOkResMap(model);
    res.send(jsonEncode(responseMap));
  }

  orderController(HttpRequest req, HttpResponse res) async {}
  orderEditController(HttpRequest req, HttpResponse res) async {}
  orderDeleteController(HttpRequest req, HttpResponse res) async {}
  orderCreateController(HttpRequest req, HttpResponse res) async {}

  //PRODUCTS
  allProductsController(HttpRequest req, HttpResponse res) async {}
  productController(HttpRequest req, HttpResponse res) async {}
}
