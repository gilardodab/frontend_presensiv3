// Auth Response Model 
import 'dart:convert';

class AuthResponseModel {
  String? token;  // Token yang diperoleh dari login

  AuthResponseModel({
    this.token,
  });
    AuthResponseModel copyWith({
    String? token,
  }) =>
      AuthResponseModel(
        token: token ?? this.token,
      );

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
      };
}