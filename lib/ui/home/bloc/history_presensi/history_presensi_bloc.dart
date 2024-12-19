import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/response/history_presensi_response_model.dart';
import '../../../../data/datasources/riwayatpresensi_datasource.dart';

part 'history_presensi_event.dart';
part 'history_presensi_state.dart';
part 'history_presensi_bloc.freezed.dart';

class HistoryPresensiBloc extends Bloc<HistoryBulananPresensiEvent, HistoryBulananPresensiState> {
  final RiwayatPresensiRemoteDataSource _riwayatPresensiRemoteDataSource;

  // Konstruktor
  HistoryPresensiBloc(this._riwayatPresensiRemoteDataSource) : super(const _Initial()) {
    // Handle event untuk mengambil riwayat presensi
    on<_GetPresensi>((event, emit) async {
      emit(const _Loading()); // Set loading state
      final result = await _riwayatPresensiRemoteDataSource.fetchRiwayatPresensi();
      result.fold(
        (message) => emit(_Error(message)), // Jika gagal, emit error
        (riwayatPresensiResponse) {
          if (riwayatPresensiResponse.data!.isEmpty) {
            emit(const _Empty()); // Jika kosong, emit empty state
          } else {
            emit(_Loaded(riwayatPresensiResponse.data!)); // Emit data riwayat
          }
        },
      );
    });

    // Handle event untuk update riwayat presensi
    on<_UpdateRiwayatPresensi>((event, emit) async {
      emit(const _Loading()); // Set loading state
      final result = await _riwayatPresensiRemoteDataSource.updateRiwayat(event.riwayatPresensi);
      result.fold(
        (message) => emit(_Error(message)), // Jika gagal, emit error
        (l) => emit(const _Success('Berhasil update riwayat presensi')), // Jika berhasil, emit success
      );
    });
  }
}
