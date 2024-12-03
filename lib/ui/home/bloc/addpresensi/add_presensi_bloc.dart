import 'dart:async';
import '../../../../data/datasources/add_presensi_datasource.dart';
import 'add_presensi_state.dart';

class AddPresensiBloc {
  final AddPresensiDataSource dataSource;
  final _presensiController = StreamController<AddPresensiState>();

  AddPresensiBloc({required this.dataSource});

  Stream<AddPresensiState> get presensiStream => _presensiController.stream;

  Future<void> addPresensi({
    required String latitude,
    required String longitude,
    required String pictureBase64,
  }) async {
    _presensiController.sink.add(AddPresensiLoadingState());

    try {
      final response = await dataSource.addPresensi(
        latitude: latitude,
        longitude: longitude,
        pictureBase64: pictureBase64,
      );
      _presensiController.sink.add(AddPresensiSuccessState(response));
    } catch (e) {
      _presensiController.sink.add(AddPresensiErrorState(e.toString()));
    }
  }

  void dispose() {
    _presensiController.close();
  }
}
