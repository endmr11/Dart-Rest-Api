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
    if (model.isNotEmpty) {
      final responseMap = generateOkResMap("/orders/all-orders", "Success", model, true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/orders/all-orders", "All Orders Error", {}, true));
    }
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
      final responseMap = generateOkResMap("/orders/order/$orderId", "Success", model, true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/orders/order/$orderId", "Order Error", {}, true));
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
      final responseMap = generateOkResMap("/orders/my-order/$userId", "Success", model, true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/orders/my-order/$userId", "My Order Error", {}, false));
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
      final responseMap = generateOkResMap("/orders/order-create", "Success", model, true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/orders/order-create", "Create Order Error", {}, false));
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
      final responseMap = generateOkResMap("/orders/order-update/$orderId", "Success", model, true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/orders/order-update/$orderId", "Update Error", {}, false));
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
      final responseMap = generateOkResMap("/orders/order-update/$orderId", "Success", model, true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/orders/order-update/$orderId", "Delete Error", {}, false));
    }
  }
}
