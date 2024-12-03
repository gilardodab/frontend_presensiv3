import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio});

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(url, data: data);
      return response;
    } on DioError catch (e) {
      rethrow;
    }
  }

  // Mendapatkan data dengan header berisi token
  Future<Response> get(String url, {required Map<String, String> headers}) async {
    try {
      final response = await dio.get(
        url,
        options: Options(headers: headers), // Menambahkan header ke permintaan
      );
      return response;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(url, data: data);
      return response;
    } on DioError catch (e) {
      rethrow;
    }
  }
}
