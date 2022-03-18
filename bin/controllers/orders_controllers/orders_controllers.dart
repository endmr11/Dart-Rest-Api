import 'dart:convert';

import 'package:alfred/alfred.dart';

import '../../config/config.dart';

class OrdersControllers extends Config {
  allOrdersController(HttpRequest req, HttpResponse res) async {
    print("Controller: allOrdersController start");
    final response = await dbConfig.getAllOrders();
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'order_id': element[0], 'user_id': element[1], 'products': element[2]};
      model.add(modelMap);
    }
    final responseMap = generateOkResMap(model);
    res.send(jsonEncode(responseMap));
  }

  orderController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderController start");
    final orderId = req.params['id'];
    final response = await dbConfig.getOrder(orderId);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'order_id': element[0], 'user_id': element[1], 'products': element[2]};
      model.add(modelMap);
    }
    final responseMap = generateOkResMap(model);
    res.send(jsonEncode(responseMap));
  }

  orderCreateController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderCreateController start");
    final body = await req.bodyAsJsonMap;
    final success = await dbConfig.createOrder(body);
    if (success) {
      final responseMap = generateOkResMap(body);
      res.send(jsonEncode(responseMap));
    } else {
      final responseMap = generateErrorResMap("Create Error");
      res.send(jsonEncode(responseMap));
    }
  }

  orderEditController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderEditController start");
    final orderId = req.params['id'];
    final body = await req.bodyAsJsonMap;
    final response = await dbConfig.editOrder(orderId, body);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'order_id': element[0], 'user_id': element[1], 'products': element[2]};
      model.add(modelMap);
    }
    final responseMap = generateOkResMap(model);
    res.send(jsonEncode(responseMap));
  }

  orderDeleteController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderDeleteController start");
    final orderId = req.params['id'];
    print(orderId);
  }
}
