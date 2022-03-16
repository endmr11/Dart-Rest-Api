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

    //throw AlfredException(401, {'message': 'authentication failed'});
  }
}