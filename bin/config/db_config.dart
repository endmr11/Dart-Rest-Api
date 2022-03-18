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
      List<List<dynamic>> results = await connection!.query("SELECT * FROM orders");

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

  Future<List<List<dynamic>>> editOrder(String orderId, Map<String, dynamic> body) async {
    try {
      List<List<dynamic>> results = await connection!.query(
          "UPDATE orders SET user_id = @userId, products = @productsVal WHERE order_id = @orderId  RETURNING *;",
          substitutionValues: {"orderId": orderId, "userId": body['user_id'], "productsVal": jsonEncode(body['products'])});
      return results;
    } catch (e) {
      return [
        [e.toString()]
      ];
    }
  }

  Future<bool> createOrder(Map<String, dynamic> body) async {
    try {
      var nBody = jsonEncode(body['products']);
      var nBodyVal = nBody.toString().replaceAll('[', '').replaceAll(']', '');
      int results = await connection!.execute("INSERT INTO orders(order_id,user_id, products) VALUES (DEFAULT,${body['user_id']}, '[$nBodyVal]')");
      return (results == 1) ? true : false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteOrder(String id) async {
    try {
      int results = await connection!.execute("DELETE FROM links WHERE order_id = $id");
      return (results == 1) ? true : false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
