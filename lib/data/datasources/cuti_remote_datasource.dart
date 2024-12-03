import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants/variables.dart';
import '../models/response/cuti_response_model.dart';
import 'auth_local_datasource.dart';

class CutiDataSource {
  // Access AuthLocalDatasource directly without storing it as a field
  final AuthLocalDatasource _authLocalDatasource = AuthLocalDatasource();

  // Helper function to handle common HTTP request logic
  Future<http.Response> _makeRequest(
    String url,
    String method, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final authData = await _authLocalDatasource.getAuthData();
    if (authData?.token == null) {
      throw Exception('Token is null');
    }

    final requestHeaders = {
      'Authorization': 'Bearer ${authData?.token}',
      'Content-Type': 'application/json',
      ...?headers, // Merge additional headers if provided
    };

    final uri = Uri.parse(url);
    http.Response response;

    switch (method.toLowerCase()) {
      case 'get':
        response = await http.get(uri, headers: requestHeaders);
        break;
      case 'post':
        response = await http.post(uri, headers: requestHeaders, body: json.encode(body));
        break;
      case 'put':
        response = await http.put(uri, headers: requestHeaders, body: json.encode(body));
        break;
      case 'delete':
        response = await http.delete(uri, headers: requestHeaders);
        break;
      default:
        throw Exception('Unsupported HTTP method: $method');
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to make request. Status code: ${response.statusCode}. Response: ${response.body}');
    }

    return response;
  }

  // Fetch the cuti data
  Future<List<Cuti>> fetchCutiData() async {
    final response = await _makeRequest('${Variables.baseUrl}/cuti/data-cuti', 'get');
    final data = json.decode(response.body);
    final List<dynamic> cutiList = data['data'];
    return cutiList.map((cutiJson) => Cuti.fromJson(cutiJson)).toList();
  }

  // Add a new cuti
  Future<void> addCuti(Cuti cuti) async {
    await _makeRequest(
      '${Variables.baseUrl}/cuti/tambah-data-cuti',
      'post',
      body: cuti.toJson(),
    );
  }

  // Edit an existing cuti
  Future<void> editCuti(int id, Cuti cuti) async {
    await _makeRequest(
      '${Variables.baseUrl}/cuti/edit-data-cuti/$id',
      'put',
      body: cuti.toJson(),
    );
  }

  // Delete a cuti
  Future<void> deleteCuti(int id) async {
    await _makeRequest('${Variables.baseUrl}/cuti/hapus-data-cuti/$id', 'delete');
  }
}
