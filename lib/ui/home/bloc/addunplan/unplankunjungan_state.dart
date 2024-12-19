import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/request/selfie_unplan_request_model.dart';

part 'unplankunjungan_state.freezed.dart';

@freezed
class UnplanKunjunganState with _$UnplanKunjunganState {
  const factory UnplanKunjunganState.initial() = _Initial;
  const factory UnplanKunjunganState.loading() = _Loading;
  const factory UnplanKunjunganState.loaded(CheckinRequestUnplan responseModel) = _Loaded;
  const factory UnplanKunjunganState.error(String message) = _Error;
}
