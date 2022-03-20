import 'dart:convert';

import 'package:alfred/alfred.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../config/config.dart';

class LoginControllers extends Config {
  refreshController(HttpRequest req, HttpResponse res) async {
    print("Controller: refreshController start");
    final body = await req.bodyAsJsonMap;
    try {
      jwtAuth.setJwtPayload(body['email']);
      final token = jwtAuth.myJwt.sign(SecretKey(jwtAuth.secretKey), expiresIn: Duration(minutes: 3));
      List<Map<String, dynamic>> model = [];
      Map<String, dynamic> modelMap = {
        "token": token,
      };
      model.add(modelMap);
      final responseMap = generateOkResMap("/refresh/token", model);
      res.send(jsonEncode(responseMap));
    } catch (e) {
      throw AlfredException(400, generateErrorResMap("/refresh/token", {"error": e.toString()}));
    }
  }

  loginController(HttpRequest req, HttpResponse res) async {
    print("Controller: loginController start");
    final body = await req.bodyAsJsonMap;

    try {
      jwtAuth.setJwtPayload(body['email']);
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
          "user_type": element[5],
        };
        model.add(modelMap);
      }

      final responseMap = generateOkResMap("/login", model);
      res.send(jsonEncode(responseMap));
    } catch (e) {
      throw AlfredException(400, generateErrorResMap("/login", {"error": e.toString()}));
    }
  }
}
