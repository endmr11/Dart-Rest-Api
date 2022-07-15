import 'dart:convert';

import 'package:alfred/alfred.dart';

import '../../config/config.dart';

class UsersControllers extends Config {
  userController(HttpRequest req, HttpResponse res) async {
    print("Controller: userController start");
    final userId = req.params['id'];
    final response = await dbConfig.getUser(userId);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {
        'user_id': element[0],
        'user_name': element[1],
        'user_surname': element[2],
        'user_email': element[3],
        'user_type': element[5]
      };
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      final responseMap = generateOkResMap("/users/user/$userId", "Success", model, true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/users/user/$userId", "User Error", {}, false));
    }
  }
}
