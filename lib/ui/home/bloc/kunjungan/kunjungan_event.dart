part of 'kunjungan_bloc.dart';

@freezed
class KunjunganEvent with _$KunjunganEvent {
  const factory KunjunganEvent.started() = _Started;
  const factory KunjunganEvent.fetchKunjungan() = _Kunjungan; // Correct this
}
