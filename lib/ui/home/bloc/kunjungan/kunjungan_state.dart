part of 'kunjungan_bloc.dart';

@freezed
class KunjunganState with _$KunjunganState {
  const factory KunjunganState.initial() = _Initial;
  const factory KunjunganState.loading() = _Loading;
  const factory KunjunganState.loaded(KunjunganResponseModel kunjungan) = _Loaded;
  const factory KunjunganState.error(String message) = _Error;
  const factory KunjunganState.empty() = _Empty;
}
