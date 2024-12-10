import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:frontend_presensiv3/core/constants/variables.dart';
import 'package:http/http.dart' as http;
import '../models/response/auth_response_model.dart';
import '../models/response/unauthenticated_response_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String username, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/login');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    }else if(response.statusCode == 404){
      return const Left('Email salah');
    }else if (response.statusCode == 401){
      return const Left('Password salah');
    }
     else {
      return const Left('Failed to login');
    }
  }

  //logout
  Future<Either<UnauthenticatedResponseModel, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/logout');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return const Right('Logged in successfully');
    } else {
      return Left(UnauthenticatedResponseModel.fromJson(response.body));
    }
  }



  // Future<void> updateFcmToken(String fcmToken) async {
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final url = Uri.parse('${Variables.baseUrl}/api/update-fcm-token');
  //   await http.post(
  //     url,
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${authData?.token}',
  //     },
  //     body: jsonEncode({
  //       'fcm_token': fcmToken,
  //     }),
  //   );
  // }



}