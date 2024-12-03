import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../core/constants/variables.dart';
import '../models/response/riwayatpresensi_response_model.dart';
import 'auth_local_datasource.dart';
import 'package:http/http.dart' as http;


class RiwayatPresensiRemoteDataSource {
  Future<Either<String, RiwayatPresensiResponse>> fetchRiwayatPresensi() async {
    try {
      // Retrieve authentication data (token)
      final authData = await AuthLocalDatasource().getAuthData();

      // Check if token is available
      if (authData?.token == null) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/presensi/loadsemua');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        return Right(RiwayatPresensiResponse.fromJson(response.body));
      } else {
        // Handle different HTTP status codes with appropriate messages
        return Left(_getErrorMessageForStatusCode(response.statusCode));
      }
    } catch (e) {
      return Left('Failed to get data: $e');
    }
  }

    // Fungsi untuk update data presensi
  Future<Either<String, String>> updateRiwayat(int presenceId, int presentId, String? information) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      if (authData?.token == null) {
        return const Left('Authorization token is missing');
      }

      final url = Uri.parse('${Variables.baseUrl}/edit-data-presensi/$presenceId');
      final response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
        body: json.encode({
          'present_id': presentId,
          'information': information,
        }),
      );

      if (response.statusCode == 200) {
        return const Right('Data presensi berhasil diperbarui');
      } else {
        return Left(_getErrorMessageForStatusCode(response.statusCode));
      }
    } catch (e) {
      return Left('Failed to update data: $e');
    }
  }



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
