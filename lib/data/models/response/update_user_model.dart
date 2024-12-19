import 'dart:convert';

import 'package:frontend_presensiv3/data/models/response/user_response_model.dart';


class UserResponseModel {
  final String? message;
  final Data? data;

  UserResponseModel({
    this.message,
    this.data,
  });


  // Update fromJson to accept a Map<String, dynamic> instead of a String
  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel.fromMap(json);

  // Method to convert to JSON string
  String toJson() => json.encode(toMap());

  // Map the response to the model
  factory UserResponseModel.fromMap(Map<String, dynamic> json) => UserResponseModel(
        message: json["status"],
        data: json["data"] != null ? Data.fromMap(json["data"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "status": message,
        "data": data?.toMap(),
      };
}