// failure.dart

// Base class for all failures
abstract class Failure {
  final String message;

  Failure(this.message);
}

// Failure ketika terjadi masalah pada server atau API
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

// Failure ketika tidak ada koneksi internet (network issue)
class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

// Failure ketika ada input yang tidak valid
class InvalidInputFailure extends Failure {
  InvalidInputFailure(String message) : super(message);
}

// Failure untuk kasus otentikasi (misalnya: password salah)
class AuthenticationFailure extends Failure {
  AuthenticationFailure(String message) : super(message);
}
