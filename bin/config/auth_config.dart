import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthConfig {
  JWT? jwt;

  final String secretKey = "eren34demir";

  JWT get myJwt => jwt!;
  void setJwtPayload(String email, String password) {
    jwt = JWT({'sub': 'login', 'email': email, 'password': password, 'iss': 'http://localhost:8080'});
  }

  int jwtVerify(String token) {
    try {
      jwt = JWT.verify(token, SecretKey(secretKey));
      return 0;
    } on JWTExpiredError {
      return 1;
    } on JWTError catch (ex) {
      print(ex.message);
      return 2;
    }
  }
}
