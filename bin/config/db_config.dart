
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
      return [];
    }
  }
}
