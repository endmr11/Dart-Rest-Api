import 'dart:convert';
import 'dart:developer';

import 'package:alfred/alfred.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../config/config.dart';
import '../models/login_response_model.dart';

class Controllers extends Config {
  loginController(HttpRequest req, HttpResponse res) async {
    log("loginController start", name: "Controller: ");
    final body = await req.bodyAsJsonMap;

    try {
      jwtAuth.setJwtPayload(body['email'], body['password']);
      final token = jwtAuth.myJwt.sign(SecretKey(jwtAuth.secretKey), expiresIn: Duration(days: 1));
      print(body['email']);
      print(body['password']);
      print(token);
      LoginResponse model = LoginResponse(name: "Eren", surname: "Demir", email: "erndemir.1@gmail.com", token: token, userGroup: 0);
      final responseMap = appUtils.generateOkResMap(model);
      res.send(jsonEncode(responseMap));
    } catch (e) {
      final responseMap = appUtils.generateErrorResMap(e.toString());
      res.send(jsonEncode(responseMap));
    }
  }
}
