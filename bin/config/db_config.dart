import 'dart:convert';

import 'package:postgres/postgres.dart';

class DbConfig {
  static PostgreSQLConnection? connection;
  Future<bool> initDb() async {
    try {
      connection = PostgreSQLConnection("127.0.0.1", 5432, "orderdb", username: "postgres", password: "123456789");
      await connection?.open();

      return true;
    } catch (e) {
      print("DB EXCEPTION: ${e.toString()}");
      return false;
    }
  }

  Future<bool> userExist(String email, String password) async {
    try {
      List<List<dynamic>> results =
          await connection!.query("SELECT user_password FROM users WHERE user_email = @userEmailValue", substitutionValues: {"userEmailValue": email});
      return results.first.first == password ? true : false;
    } catch (e) {
      return false;
    }
  }

  Future<List<List<dynamic>>> getUserInfo(String email) async {
    try {
      List<List<dynamic>> results =
          await connection!.query("SELECT * FROM users WHERE user_email = @userEmailValue", substitutionValues: {"userEmailValue": email});
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> getAllOrders() async {
    try {
      List<List<dynamic>> results = await connection!.query("SELECT * FROM orders ORDER BY order_id DESC");

      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> getMyOrders(String userId) async {
    try {
      List<List<dynamic>> results =
          await connection!.query("SELECT * FROM orders WHERE user_id=@userId ORDER BY order_id DESC", substitutionValues: {"userId": userId});

      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> getOrder(String orderId) async {
    try {
      List<List<dynamic>> results = await connection!.query("SELECT * FROM orders WHERE order_id = @orderId", substitutionValues: {"orderId": orderId});
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> updateOrder(String orderId, Map<String, dynamic> body) async {
    try {
      List<List<dynamic>> results = await connection!.query(
          "UPDATE orders SET user_id = @userId, products = @productsVal,user_name =@userName,user_surname=@userSurname,order_status=@orderStatus WHERE order_id = @orderId  RETURNING *;",
          substitutionValues: {
            "orderId": orderId,
            "userId": body['user_id'],
            "productsVal": jsonEncode(body['products']),
            "userName": body['user_name'],
            "userSurname": body['user_surname'],
            "orderStatus": body['order_status']
          });
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> createOrder(Map<String, dynamic> body) async {
    try {
      var nBody = jsonEncode(body['products']);
      var nBodyVal = nBody.toString().replaceAll('[', '').replaceAll(']', '');
      List<List<dynamic>> results = await connection!.query(
          "INSERT INTO orders(order_id,user_id,products,user_name,user_surname,order_status) VALUES (DEFAULT,${body['user_id']}, '[$nBodyVal]','${body['user_name']}','${body['user_surname']}',${body['order_status']})  RETURNING *;");
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> deleteOrder(String orderId) async {
    try {
      List<List<dynamic>> results =
          await connection!.query("DELETE FROM orders WHERE order_id = @orderId  RETURNING *;", substitutionValues: {"orderId": orderId});
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> getAllProducts() async {
    try {
      List<List<dynamic>> results = await connection!.query("SELECT * FROM products");

      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> getProduct(String productId) async {
    try {
      List<List<dynamic>> results =
          await connection!.query("SELECT * FROM products WHERE product_id = @productId", substitutionValues: {"productId": productId});
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<List<List<dynamic>>> getUser(String userId) async {
    try {
      List<List<dynamic>> results = await connection!.query("SELECT * FROM users WHERE user_id = @userId", substitutionValues: {"userId": userId});
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }
}
