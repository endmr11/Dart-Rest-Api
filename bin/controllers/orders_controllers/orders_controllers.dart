import 'dart:convert';

import 'package:alfred/alfred.dart';

import '../../config/config.dart';

class OrdersControllers extends Config {
  allOrdersController(HttpRequest req, HttpResponse res) async {
    print("Controller: allOrdersController start");
    final response = await dbConfig.getAllOrders();
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {
        'order_id': element[0],
        'user_id': element[1],
        'products': element[2],
        'user_name': element[3],
        'user_surname': element[4],
        'order_status': element[5]
      };
      model.add(modelMap);
    }
    final responseMap = generateOkResMap("/orders/all-orders", model);
    res.send(jsonEncode(responseMap));
  }

  orderController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderController start");
    final orderId = req.params['id'];
    final response = await dbConfig.getOrder(orderId);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {
        'order_id': element[0],
        'user_id': element[1],
        'products': element[2],
        'user_name': element[3],
        'user_surname': element[4],
        'order_status': element[5]
      };
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      final responseMap = generateOkResMap("/orders/order/$orderId", model);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateErrorResMap("/orders/order/$orderId", {"error": "Order Error"}));
    }
  }

  myOrderController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderController start");
    final userId = req.params['id'];
    final response = await dbConfig.getMyOrders(userId);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {
        'order_id': element[0],
        'user_id': element[1],
        'products': element[2],
        'user_name': element[3],
        'user_surname': element[4],
        'order_status': element[5]
      };
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      final responseMap = generateOkResMap("/orders/my-order/$userId", model);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateErrorResMap("/orders/my-order/$userId", {"error": "Order Error"}));
    }
  }

  orderCreateController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderCreateController start");
    final body = await req.bodyAsJsonMap;
    final response = await dbConfig.createOrder(body);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {
        'order_id': element[0],
        'user_id': element[1],
        'products': element[2],
        'user_name': element[3],
        'user_surname': element[4],
        'order_status': element[5]
      };
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      socketConfig.createOrderSend(model);
      final responseMap = generateOkResMap("/orders/order-create", model);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateErrorResMap("/orders/order-create", {"error": "Create Error"}));
    }
  }

  orderUpdateController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderUpdateController start");
    final orderId = req.params['id'];
    final body = await req.bodyAsJsonMap;
    final response = await dbConfig.updateOrder(orderId, body);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {
        'order_id': element[0],
        'user_id': element[1],
        'products': element[2],
        'user_name': element[3],
        'user_surname': element[4],
        'order_status': element[5]
      };
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      socketConfig.updateOrderSend(model);
      final responseMap = generateOkResMap("/orders/order-update/$orderId", model);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateErrorResMap("/orders/order-update/$orderId", {"error": "Update Error"}));
    }
  }

  orderDeleteController(HttpRequest req, HttpResponse res) async {
    print("Controller: orderDeleteController start");
    final orderId = req.params['id'];
    final response = await dbConfig.deleteOrder(orderId);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {
        'order_id': element[0],
        'user_id': element[1],
        'products': element[2],
        'user_name': element[3],
        'user_surname': element[4],
        'order_status': element[5]
      };
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      socketConfig.deleteOrderSend(model);
      final responseMap = generateOkResMap("/orders/order-update/$orderId", model);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateErrorResMap("/orders/order-update/$orderId", {"error": "Delete Error"}));
    }
  }
}
