import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthConfig {
  JWT? jwt;

  final String secretKey = "eren34demir";

  JWT get myJwt => jwt!;
  void setJwtPayload(String email) {
    jwt = JWT({'email': email, 'iss': 'http://localhost:8080'});
  }

  int jwtVerify(String token) {
    try {
      jwt = JWT.verify(token, SecretKey(secretKey));
      return 0;
    } on JWTExpiredError {
      print("jwt expired");
      return 1;
    } on JWTError catch (ex) {
      print(ex.message);
      return 2;
    }
  }
}
