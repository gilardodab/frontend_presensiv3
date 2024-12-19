
import 'package:dartz/dartz.dart';
import 'package:frontend_presensiv3/data/datasources/auth_local_datasource.dart';

import '../../core/constants/variables.dart';
import '../models/request/selfie_kunjungan_request_model.dart';
import '../models/request/selfie_unplan_request_model.dart';
import '../models/response/kunjungan_response_model.dart';
import 'package:http/http.dart' as http;

class KunjunganRemoteDatasource {
  Future<Either<String, KunjunganResponseModel>> fetchKunjungan() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/kunjungan/jadwal-data-kunjungan');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );
    if (response.statusCode == 200) {
      return Right(KunjunganResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Memuat data kunjungan');
    }
  }


Future<Either<String, CheckinRequestKunjungan>> checkin(
    CheckinRequestKunjungan data) async {
  try {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/kunjungan/presensi-kunjungan');
    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(CheckinRequestKunjungan.fromJson(response.body));
    } else {
      final errorMsg = response.body.isNotEmpty ? response.body : 'Failed to checkin';
      return Left(errorMsg);
    }
  } catch (e) {
    return Left('Error: $e');
  }
}

Future<Either<String, CheckinRequestUnplan>> unplan(
    CheckinRequestUnplan data) async {
  try {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/kunjungan/kunjungan-unplan');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(CheckinRequestUnplan.fromJson(response.body));
    } else {
      final errorMsg = response.body.isNotEmpty ? response.body : 'Gagal melakukan presensi Kunjungan UNPLAN';
      return Left(errorMsg);
    }
  } catch (e) {
    return Left('Error: $e');
  }
}


  // Future<Either<String, KunjunganResponseModel>> checkin(String kunjunganId,
  //     String latitude, String longitude, String pictureBase64) async {
  //   print('kunjunganId: $kunjunganId');
  //   print('latitude: $latitude');
  //   print('longitude: $longitude');
  //   print('pictureBase64: $pictureBase64');
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final url = Uri.parse('${Variables.baseUrl}/kunjungan/presensi-kunjungan');
  //   final response = await http.put(
  //     url,
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${authData?.token}',
  //     },
  //     body: json.encode({
  //       'kunjungan_id': kunjunganId,
  //       'latitude': latitude,
  //       'longitude': longitude,
  //       'picture': pictureBase64,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     return Right(KunjunganResponseModel.fromJson(jsonDecode(response.body)));
  //   } else if (response.statusCode == 401) {
  //     return Left(response.reasonPhrase!);
  //   } else if (response.statusCode == 422) {
  //     return Left(response.reasonPhrase!);
  //   } else
  //     return const Left('Failed to checkin');
  // }

  //   Future<KunjunganResponseModel> addPresensi({
  //   required String latitude,
  //   required String longitude,
  //   required String pictureBase64,
  // }) async {
  //   var  authData = await AuthLocalDatasource().getAuthData();
  //   final response = await http.post(
  //     Uri.parse('${Variables.baseUrl}/presensi/selfie'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${authData?.token}', // Add the proper token here
  //     },
  //     body: jsonEncode({
  //       'latitude': latitude,
  //       'longitude': longitude,
  //       'picture': pictureBase64,
  //     }),
  //   );

  // if (response.statusCode == 201) {
  //     // Successfully created
  //     return KunjunganResponseModel.fromJson(jsonDecode(response.body));
  //   } else if (response.statusCode == 200) {
  //     // Resource not found
  //     // You can return a specific response, for example:
  //           return Right(KunjunganResponseModel.fromJson(response.body));
  //   } else if (response.statusCode == 400) {
  //     // Unauthorized, probably token expired or invalid credentials
  //     // Return a response with an appropriate message, for example:
  //     return KunjunganResponseModel(status: 'error', message: 'Kamu sudah melakukan presensi sebelumnya');
  //   } else {
  //     // For all other status codes
  //     throw Exception('Gagal melakukan presensi. Status code: ${response.statusCode}');
  //   }
  // }

  Future<Either<String, KunjunganResponseModel>> riwayatKunjungan() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/kunjungan/riwayat-kunjungan');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );
    if (response.statusCode == 200) {
      return Right(KunjunganResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Memuat data kunjungan');
    }
  }
}
