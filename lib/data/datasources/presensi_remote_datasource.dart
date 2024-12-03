import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:frontend_presensiv3/data/datasources/auth_local_datasource.dart';
import 'package:frontend_presensiv3/data/models/response/presensi_response_model.dart';
import 'package:dio/dio.dart';  // Import Dio
import '../../core/constants/variables.dart';

class PresensiRemoteDataSource {
  final Dio _dio;

  // Constructor to initialize Dio
  PresensiRemoteDataSource(this._dio);

  // Method to get the presensi data
  Future<Either<String, PresensiResponseModel>> getPresensi() async {
    try {
      // Retrieve authentication data (token)
      final authData = await AuthLocalDatasource().getAuthData();

      // Check if token is available
      if (authData?.token == null) {
        return const Left('Authorization token is missing');
      }

      // Prepare the URL for the GET request
      final url = '${Variables.baseUrl}/presensi/seminggu';

      // Send the GET request using Dio
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authData?.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Parse the response and return it
        return Right(PresensiResponseModel.fromJson(response.data));
      } else {
        // Handle different HTTP status codes with appropriate messages
        return Left(_getErrorMessageForStatusCode(response.statusCode!));
      }
    } catch (e) {
      // Handle different error scenarios with Dio's error handling
      if (e is DioError) {
        // Handle DioError (network issues, timeouts, etc.)
        return Left(_handleDioError(e));
      } else if (e is SocketException) {
        return const Left('No internet connection');
      } else if (e is TimeoutException) {
        return const Left('Request timed out. Please try again later.');
      } else {
        return Left('An unexpected error occurred: ${e.toString()}');
      }
    }
  }

  // Handle Dio errors specifically
  String _handleDioError(DioError e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timed out. Please try again later.';
    } else if (e.type == DioExceptionType.sendTimeout) {
      return 'Send timeout occurred. Please try again later.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout occurred. Please try again later.';
    } else if (e.type == DioExceptionType.badResponse) {
      // Server response with an error (non-2xx status)
      return _getErrorMessageForStatusCode(e.response?.statusCode ?? 500);
    } else if (e.type == DioExceptionType.cancel) {
      return 'Request was cancelled. Please try again later.';
    } else {
      return 'Unexpected error occurred: ${e.message}';
    }
  }

  // Map HTTP status codes to user-friendly error messages
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
