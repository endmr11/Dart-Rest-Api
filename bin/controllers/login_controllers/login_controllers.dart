import 'dart:convert';

import 'package:alfred/alfred.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../config/config.dart';

class LoginControllers extends Config {
  loginController(HttpRequest req, HttpResponse res) async {
    print("Controller: loginController start");
    final body = await req.bodyAsJsonMap;

    try {
      jwtAuth.setJwtPayload(body['email'], body['password']);
      final token = jwtAuth.myJwt.sign(SecretKey(jwtAuth.secretKey), expiresIn: Duration(days: 1));
      final userInfo = await dbConfig.getUserInfo(body['email']);
      List<Map<String, dynamic>> model = [];

      for (final element in userInfo) {
        Map<String, dynamic> modelMap = {
          "id": element[0],
          "name": element[1],
          "surname": element[2],
          "email": element[3],
          "token": token,
          "user_group": element[5],
        };
        model.add(modelMap);
      }

      final responseMap = generateOkResMap("/login", model);
      res.send(jsonEncode(responseMap));
    } catch (e) {
      final responseMap = generateErrorResMap("/login", e.toString());
      res.send(jsonEncode(responseMap));
    }
  }
}
