import 'dart:convert';

import 'package:alfred/alfred.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../config/config.dart';
import '../models/login_response_model.dart';

class Controllers extends Config {
  loginController(HttpRequest req, HttpResponse res) async {
    print("Controller: loginController start");
    final body = await req.bodyAsJsonMap;

    try {
      jwtAuth.setJwtPayload(body['email'], body['password']);
      final token = jwtAuth.myJwt.sign(SecretKey(jwtAuth.secretKey), expiresIn: Duration(days: 1));
      final userInfo = await dbConfig.getUserInfo(body['email']);

      LoginResponse model = LoginResponse(
        id: userInfo.first[0],
        name: userInfo.first[1],
        surname: userInfo.first[2],
        email: userInfo.first[3],
        token: token,
        userGroup: userInfo.first[5],
      );
      final responseMap = appUtils.generateOkResMap(model);
      res.send(jsonEncode(responseMap));
    } catch (e) {
      final responseMap = appUtils.generateErrorResMap(e.toString());
      res.send(jsonEncode(responseMap));
    }
  }

  allOrdersController(HttpRequest req, HttpResponse res) async {
    print("Controller: allOrdersController start");
    final body = await req.bodyAsJsonMap;
    final responseMap = appUtils.generateOkResMap(body);
    res.send(jsonEncode(responseMap));
  }
}
