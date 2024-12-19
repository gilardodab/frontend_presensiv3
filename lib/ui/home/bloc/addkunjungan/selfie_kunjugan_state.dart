import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/request/selfie_kunjungan_request_model.dart';

part 'selfie_kunjugan_state.freezed.dart';

@freezed
class SelfieKunjunganState with _$SelfieKunjunganState {
  const factory SelfieKunjunganState.initial() = _Initial;
  const factory SelfieKunjunganState.loading() = _Loading;
  const factory SelfieKunjunganState.loaded(CheckinRequestKunjungan responseModel) = _Loaded;
  const factory SelfieKunjunganState.error(String message) = _Error;
}
