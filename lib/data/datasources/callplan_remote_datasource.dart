import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/variables.dart';
import '../models/response/callplan_response_model.dart';
import 'auth_local_datasource.dart';


class CallPlanDataSource {


Future<List<CallPlanModel>> loadCallPlans(String fromDate, String toDate) async {
  try {
    final authData = await AuthLocalDatasource().getAuthData();

    // Check if token is available
    if (authData?.token == null) {
      return [];
    }

    final token = authData?.token;
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/data-callplan?from=$fromDate&to=$toDate'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        // Ensure the response 'data' is a list and map it to CallPlanModel
        List<dynamic> callplansData = data['data'];

        // Map the List<dynamic> to List<CallPlanModel> correctly
        return callplansData.map((item) {
          if (item is Map<String, dynamic>) {
            return CallPlanModel.fromJson(item);
          } else {
            throw Exception('Invalid data format');
          }
        }).toList();
      } else {
        throw Exception('Failed to load callplans');
      }
    } else {
      throw Exception('Failed to load callplans');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}


  Future<bool> createCallPlan(CallPlanModel callPlan) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/tambah-data-callplan'),
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: json.encode(callPlan.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to create callplan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> updateCallPlan(CallPlanModel callPlan) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      final response = await http.put(
        Uri.parse('${Variables.baseUrl}/edit-data-callplan/${callPlan.callplanId}'),
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: json.encode(callPlan.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update callplan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> deleteCallPlan(int callPlanId) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = authData?.token;
      final response = await http.delete(
        Uri.parse('${Variables.baseUrl}/hapus-data-callplan/$callPlanId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete callplan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
