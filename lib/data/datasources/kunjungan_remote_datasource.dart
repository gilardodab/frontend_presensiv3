import 'package:dartz/dartz.dart';
import 'package:frontend_presensiv3/data/datasources/auth_local_datasource.dart';

import '../../core/constants/variables.dart';
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
}
