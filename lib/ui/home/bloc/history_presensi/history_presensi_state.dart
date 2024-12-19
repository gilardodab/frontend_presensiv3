// callplan_state.dart
part of 'history_presensi_bloc.dart';

@freezed
class HistoryBulananPresensiState with _$HistoryBulananPresensiState {
  // Initial state when the BLoC is first created
  const factory HistoryBulananPresensiState.initial() = _Initial;

  // Loading state when the data is being fetched
  const factory HistoryBulananPresensiState.loading() = _Loading;

  // State when the data is successfully loaded
  const factory HistoryBulananPresensiState.loaded(List<HistoryBulananPresensi> presensi) = _Loaded;

  // State when there is an error in fetching or processing data
  const factory HistoryBulananPresensiState.error(String message) = _Error;

  // State when no data is available
  const factory HistoryBulananPresensiState.empty() = _Empty;

  // Success state after a successful update or deletion of data
  const factory HistoryBulananPresensiState.success(String message) = _Success;
}
