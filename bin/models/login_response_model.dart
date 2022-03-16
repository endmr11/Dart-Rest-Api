import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.name,
    this.surname,
    this.email,
    this.token,
    this.userGroup,
  });

  String? name;
  String? surname;
  String? email;
  String? token;
  int? userGroup;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        token: json["token"],
        userGroup: json["user_group"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "token": token,
        "user_group": userGroup,
      };
}
