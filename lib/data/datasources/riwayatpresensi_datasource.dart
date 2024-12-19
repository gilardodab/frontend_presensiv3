import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:frontend_presensiv3/data/models/response/history_presensi_response_model.dart';
import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';
import 'package:http/http.dart' as http;


class RiwayatPresensiRemoteDataSource {
  // Future<Either<String, RiwayatPresensiResponse>> fetchRiwayatPresensi() async {
  //   try {
  //     // Retrieve authentication data (token)
  //     final authData = await AuthLocalDatasource().getAuthData();

  //     // Check if token is available
  //     if (authData?.token == null) {
  //       return const Left('Authorization token is missing');
  //     }

  //     final url = Uri.parse('${Variables.baseUrl}/presensi/loadsemua');

  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${authData?.token}',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       return Right(RiwayatPresensiResponse.fromJson(response.body));
  //     } else {
  //       // Handle different HTTP status codes with appropriate messages
  //       return Left(_getErrorMessageForStatusCode(response.statusCode));
  //     }
  //   } catch (e) {
  //     return Left('Failed to get data: $e');
  //   }
  // }



    Future<Either<String, HistoryBulananPresensiModel>> fetchRiwayatPresensi() async {
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        return Right(HistoryBulananPresensiModel.fromMap(responseData));
      } else {
        // Handle different HTTP status codes with appropriate messages
        return Left(_getErrorMessageForStatusCode(response.statusCode));
      }
    } catch (e) {
      return Left('Failed to get data: $e');
    }
  }

  Future<Either<String, void>> updateRiwayat(HistoryBulananPresensi riwayatPresensi) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;
    final response = await http.put(
      Uri.parse(
        '${Variables.baseUrl}/edit-data-presensi/${riwayatPresensi.presenceId}'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
        body: json.encode(riwayatPresensi.toMap()),
    );
    if (response.statusCode == 200) {
      return Right(null);
    } else {
      return Left('Failed to update RiwayatPresensi');
    }
  }

    // Fungsi untuk update data presensi
  // Future<Either<String, String>> updateRiwayat(int presenceId, int presentId, String? information) async {
  //   try {
  //     final authData = await AuthLocalDatasource().getAuthData();
  //     if (authData?.token == null) {
  //       return const Left('Authorization token is missing');
  //     }

  //     final url = Uri.parse('${Variables.baseUrl}/edit-data-presensi/$presenceId');
  //     final response = await http.put(
  //       url,
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${authData?.token}',
  //       },
  //       body: json.encode({
  //         'presence_id': presenceId,
  //         'information': information,
  //         'present_id': presentId
  //       }),
  //     );
  //     print(presenceId);

  //     if (response.statusCode == 200) {
  //       return const Right('Data presensi berhasil diperbarui');
  //     } else {
  //       return Left(_getErrorMessageForStatusCode(response.statusCode));
  //     }
  //   } catch (e) {
  //     return Left('Failed to update data: $e');
  //   }
  // }



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
