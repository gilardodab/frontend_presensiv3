import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants/variables.dart';
import '../models/response/cuti_response_model.dart';
import 'auth_local_datasource.dart';

class CutiRemoteDataSource {
  // Future<Either<String, CutiResponseModel>> fetchCutiData( String fromDate, String toDate) async {
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final token = authData?.token;
  //   final response = await http.get(
  //     Uri.parse('${Variables.baseUrl}/cuti/data-cuti?from=$fromDate&to=$toDate'),
  //     headers: {'Authorization': 'Bearer $token'},
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     return Right(CutiResponseModel.fromMap(responseData)); // Corrected to use fromMap
  //   } else {
  //     return const Left('Failed to fetch cuti data');
  //   }
  // }

    Future<Either<String, CutiResponseModel>> fetchCutiDataBulan() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/cuti/data-cuti'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return Right(CutiResponseModel.fromMap(responseData)); // Corrected to use fromMap
    } else {
      return const Left('Gagal Memuat data cuti');
    }
  }

  // Add a new cuti
  Future<Either<String,void>> addCuti(Cuti cuti) async {
    print(cuti.cutyStart);
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      final response = await http.post(
      Uri.parse('${Variables.baseUrl}/cuti/tambah-data-cuti'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'cuty_start' : cuti.cutyStart,
        'cuty_end' : cuti.cutyEnd,
        'date_work' : cuti.dateWork,
        'cuty_total' : cuti.cutyTotal,
        'cuty_description' : cuti.cutyDescription,
      }),
    );
    if (response.statusCode == 200) {
      return const Right(null);
    }else if (response.statusCode == 422) {
      return const Left('Failed to add cuti 422');
    }else if (response.statusCode == 500) {
      return const Left('Failed to add cuti 500');
    }
     else {
      return const Left('Gagal Menambahkan Permohonan Cuti');
    }
  }

  // Edit an existing cuti
  Future<Either<String, void>> editCuti(Cuti cuti) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;
    print(cuti.cutyId);
    final response = await http.put(
      Uri.parse(
      '${Variables.baseUrl}/cuti/edit-data-cuti/${cuti.cutyId}',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(cuti.toMap()),
    );

    if (response.statusCode == 200) {
      return const Right(null);
    }else if (response.statusCode == 422) {
      return const Left('Failed to add cuti 422');
    }else if (response.statusCode == 500) {
      return const Left('Failed to add cuti 500');
    }
     else {
      return const Left('Gagal Menambahkan Data Cuti');
    }
  }

  // Delete a cuti
  Future<Either<String, void>> deleteCuti(Cuti cuti) async {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;

  // Prepare the payload with the cuty_id
  final Map<String, dynamic> payload = {
    'cuty_id': cuti.cutyId,  // Include the cuty_id from the passed Cuti object
  };

  final response = await http.delete(
    Uri.parse('${Variables.baseUrl}/cuti/hapus-data-cuti/${cuti.cutyId}'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Add the content type as JSON
    },
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    return const Right(null);
  } else {
    return const Left('Gagal Menghapus Cuti');
  }
  }
}
