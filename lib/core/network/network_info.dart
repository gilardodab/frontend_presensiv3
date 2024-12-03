import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  Future<bool> get isConnected async {
    try {
      var result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;  // Jika terjadi error, anggap tidak ada koneksi internet
    }
  }
}
