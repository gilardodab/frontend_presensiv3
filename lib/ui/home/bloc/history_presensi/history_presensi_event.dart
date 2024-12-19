//create history presensi event
part of 'history_presensi_bloc.dart';

@freezed
class HistoryBulananPresensiEvent with _$HistoryBulananPresensiEvent {
  const factory HistoryBulananPresensiEvent.getPresensi() = _GetPresensi;
  const factory HistoryBulananPresensiEvent.updatePresensi(HistoryBulananPresensi riwayatPresensi) = _UpdateRiwayatPresensi;
}