import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk parsing JSON
import '../../core/constants/variables.dart';
import '../models/response/user_response_model.dart';
import 'auth_local_datasource.dart';

class UserRemoteDatasource {

  // Method untuk mendapatkan data user
  Future<Either<String, UserResponseModel>> getUser() async {
    try {
      // Ambil data autentikasi (token)
      final authData = await AuthLocalDatasource().getAuthData();

      // Cek apakah token tersedia
      if (authData?.token == null) {
        return const Left('Ulangi login');
      }

      // Siapkan URL
      final url = Uri.parse('${Variables.baseUrl}/karyawan/data');

      // Buat headers dengan token authorization
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return Right(UserResponseModel.fromJson(responseData));
        } else {
          return Left(responseData['message']);
        }
      } else {
        return Left(_getErrorMessageForStatusCode(response.statusCode));
      }
    } catch (e) {
      return Left('Failed to get data: $e');
    }
      }

  

  // Fungsi helper untuk menangani status code dan memberikan pesan yang sesuai
  String _getErrorMessageForStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 404:
        return 'Data not found.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Failed to get data. Status code: $statusCode';
    }
  }
}
