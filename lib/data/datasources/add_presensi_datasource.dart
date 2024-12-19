import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/variables.dart';
import '../models/response/add_presensi_response_model.dart';
import 'auth_local_datasource.dart';

class AddPresensiDataSource {

  Future<AddPresensiResponseModel> addPresensi({
    required String latitude,
    required String longitude,
    required String pictureBase64,
  }) async {
    var  authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/presensi/selfie'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}', // Add the proper token here
      },
      body: jsonEncode({
        'latitude': latitude,
        'longitude': longitude,
        'picture': pictureBase64,
      }),
    );

  if (response.statusCode == 201) {
      // Successfully created
      return AddPresensiResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      // Resource not found
      // You can return a specific response, for example:
      return AddPresensiResponseModel(status: 'success', message: 'Presensi Berhasil dilakukan');
    } else if (response.statusCode == 400) {
      // Unauthorized, probably token expired or invalid credentials
      // Return a response with an appropriate message, for example:
      return AddPresensiResponseModel(status: 'error', message: 'Kamu sudah melakukan presensi sebelumnya');
    } else {
      // For all other status codes
      throw Exception('Gagal melakukan presensi. Status code: ${response.statusCode}');
    }
  }
}
