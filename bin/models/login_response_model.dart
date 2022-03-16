import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.token,
    this.userGroup,
  });
  int? id;
  String? name;
  String? surname;
  String? email;
  String? token;
  int? userGroup;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        token: json["token"],
        userGroup: json["user_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "token": token,
        "user_group": userGroup,
      };
}
