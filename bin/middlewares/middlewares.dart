import 'dart:async';

import 'package:alfred/alfred.dart';

import '../config/config.dart';

class Middlewares extends Config {
  Future<FutureOr> loginVerify(HttpRequest req, HttpResponse res) async {
    final body = await req.bodyAsJsonMap;
    bool userExist = await dbConfig.userExist(body['email'], body['password']);
    if (!userExist) {
      throw AlfredException(401, appUtils.generateErrorResMap("Kullanıcı Bulunamadı1"));
    }
  }

  FutureOr authenticationMiddleware(HttpRequest req, HttpResponse res) async {
    final token = req.headers.value('authorization');
    int? status;
    if (token != null) {
      print("TOKEN: $token");
      status = jwtAuth.jwtVerify(token.substring(7));
    }
    if (status != null) {
      switch (status) {
        case 2:
          throw AlfredException(401, appUtils.generateJwtExpired("expired"));
        case 3:
          throw AlfredException(401, appUtils.generateJwtExpired("Token Failed!"));
      }
    }
  }
}
