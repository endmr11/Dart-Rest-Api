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
    final responseMap = generateOkResMap("/all-orders", model);
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
    if (model.isNotEmpty) {
      final responseMap = generateOkResMap("/order/$orderId", model);
      res.send(jsonEncode(responseMap));
    } else {
      final responseMap = generateErrorResMap("/order/$orderId", "Order Error");
      res.send(jsonEncode(responseMap));
    }
  }

  orderCreateController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderCreateController start");
    final body = await req.bodyAsJsonMap;
    final response = await dbConfig.createOrder(body);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'order_id': element[0], 'user_id': element[1], 'products': element[2]};
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      socketConfig.createOrderSend(model);
      final responseMap = generateOkResMap("/order-create", model);
      res.send(jsonEncode(responseMap));
    } else {
      final responseMap = generateErrorResMap("/order-create", "Create Error");
      res.send(jsonEncode(responseMap));
    }
  }

  orderUpdateController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderUpdateController start");
    final orderId = req.params['id'];
    final body = await req.bodyAsJsonMap;
    final response = await dbConfig.updateOrder(orderId, body);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'order_id': element[0], 'user_id': element[1], 'products': element[2]};
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      socketConfig.updateOrderSend(model);
      final responseMap = generateOkResMap("/order-update/$orderId", model);
      res.send(jsonEncode(responseMap));
    } else {
      final responseMap = generateErrorResMap("/order-update/$orderId", "Update Error");
      res.send(jsonEncode(responseMap));
    }
  }

  orderDeleteController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderDeleteController start");
    final orderId = req.params['id'];
    final response = await dbConfig.deleteOrder(orderId);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'order_id': element[0], 'user_id': element[1], 'products': element[2]};
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      socketConfig.deleteOrderSend(model);
      final responseMap = generateOkResMap("/order-update/$orderId", model);
      res.send(jsonEncode(responseMap));
    } else {
      final responseMap = generateErrorResMap("/order-update/$orderId", "Delete Error");
      res.send(jsonEncode(responseMap));
    }
  }
}
