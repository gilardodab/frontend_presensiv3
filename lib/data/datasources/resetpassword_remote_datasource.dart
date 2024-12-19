import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class ResetPasswordRemoteDataSource {
  Future<Either<String, String>> resetPassword(String password) async {
    var authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/karyawan/update-password-user');
    final headers = {
      'Authorization': 'Bearer ${authData?.token}',
      'Content-Type': 'application/json',
    };

    // Menggunakan http.Request untuk mengirim data dalam format JSON
    var request = http.Request('POST', url);
    request.headers.addAll(headers);
    request.body = json.encode({
      'employees_password': password,  // Kirimkan password dalam format JSON
    });

    try {
      // Kirimkan request
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return const Right('Password Berhasil Diubah');
      } else {
        return const Left('Failed to change password');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
