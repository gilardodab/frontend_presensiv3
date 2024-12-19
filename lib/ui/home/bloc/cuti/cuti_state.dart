part of 'cuti_bloc.dart';


@freezed

class CutiState with _$CutiState {
  const factory CutiState.initial() = _Initial;
  const factory CutiState.loading() = _Loading;
  const factory CutiState.loaded(List<Cuti> cuti) = _Loaded;
  const factory CutiState.error(String message) = _Error;
  const factory CutiState.empty() = _Empty;
  const factory CutiState.success(String message) = _Success;
  const factory CutiState.added(String message) = _Added;
}