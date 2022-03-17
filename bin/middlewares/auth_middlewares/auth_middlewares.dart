import 'dart:async';

import 'package:alfred/alfred.dart';

import '../../config/config.dart';

class AuthMiddlewares extends Config {
  FutureOr authenticationMiddleware(HttpRequest req, HttpResponse res) async {
    final token = req.headers.value('authorization');

    int? status;
    if (token != null) {
      print("TOKEN: $token");
      status = jwtAuth.jwtVerify(token.substring(7));
      switch (status) {
        case 2:
          throw AlfredException(401, generateJwtExpired("Token expired!"));
        case 3:
          throw AlfredException(401, generateJwtExpired("Token Failed!"));
      }
    } else {
      throw AlfredException(401, generateJwtExpired("Token Required!"));
    }
  }
}
