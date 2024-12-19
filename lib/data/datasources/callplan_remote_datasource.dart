import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/variables.dart';
import '../models/response/callplan_response_model.dart';
import 'auth_local_datasource.dart';

class CallPlanRemoteDataSource {
  Future<Either<String, CallPlanResponseModel>> loadCallPlans(
      String fromDate, String toDate) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/callplan/data-callplan?from=$fromDate&to=$toDate'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      // Decode the response body into Map<String, dynamic>
      final Map<String, dynamic> responseData = json.decode(response.body);
      return Right(CallPlanResponseModel.fromMap(
          responseData)); // Corrected to use fromMap
    } else {
      return Left('Gagal Memuat data callplan');
    }
  }

  Future<Either<String, CallPlanResponseModel>> loadCallPlansBulan() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/callplan/data-callplan'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      // Decode the response body into Map<String, dynamic>
      final Map<String, dynamic> responseData = json.decode(response.body);
      return Right(CallPlanResponseModel.fromMap(
          responseData)); // Corrected to use fromMap
    } else {
      return Left('Gagal Memuat data callplan');
    }
  }

  Future<Either<String, void>> updateCallPlan(CallPlan callPlan) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = authData?.token;

    final response = await http.put(
      Uri.parse(
          '${Variables.baseUrl}/callplan/edit-data-callplan/${callPlan.callplanId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(callPlan.toMap()),
    );

    if (response.statusCode == 200) {
      return Right(null);
    } else {
      return Left('Failed to update CallPlan');
    }
  }

Future<Either<String, void>> deleteCallPlan(CallPlan callPlan) async {
  final authData = await AuthLocalDatasource().getAuthData();
  final token = authData?.token;

  // Prepare the payload with the callplan_id
  final Map<String, dynamic> payload = {
    'callplan_id': callPlan.callplanId,  // Include the callplan_id from the passed CallPlan object
  };

  final response = await http.delete(
    Uri.parse('${Variables.baseUrl}/callplan/hapus-data-callplan'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Add the content type as JSON
    },
    body: json.encode(payload), // Encode the payload to JSON format
  );

  if (response.statusCode == 200) {
    return Right(null); // If the deletion is successful
  } else {
    return const Left('Failed to delete CallPlan'); // If there's an error
  }
}

Future<Either<String, void>> addCallPlan(CallPlan callPlan) async {
  
  final authData = await AuthLocalDatasource().getAuthData();
  final token = authData?.token;
  // Prepare the payload for the request
  // Send a POST request to the API
  final response = await http.post(
    Uri.parse('${Variables.baseUrl}/callplan/tambah-data-callplan'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Inform the server that it's a JSON request body
    },
        body: jsonEncode({
        'tanggal_cp': callPlan.tanggalCp,
        'nama_outlet': callPlan.namaOutlet,
        'description': callPlan.description,
      }),
    );


  if (response.statusCode == 201) {
      return Right(null); // Return void wrapped in Right
    } else {
      return Left('Failed to add CallPlan');
    }
  }


  // Future<bool> updateCallPlan(CallPlanResponseModel callPlan) async {
  //   try {
  //     final authData = await AuthLocalDatasource().getAuthData();
  //     final token = authData?.token;
  //     final response = await http.put(
  //       Uri.parse('${Variables.baseUrl}/edit-data-callplan/${callPlan.callplanId}'),
  //       headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
  //       body: json.encode(callPlan.toJson()),
  //     );

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception('Failed to update callplan');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  // Future<bool> deleteCallPlan(int callPlanId) async {
  //   try {
  //     final authData = await AuthLocalDatasource().getAuthData();
  //     final token = authData?.token;
  //     final response = await http.delete(
  //       Uri.parse('${Variables.baseUrl}/hapus-data-callplan/$callPlanId'),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception('Failed to delete callplan');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }
}
