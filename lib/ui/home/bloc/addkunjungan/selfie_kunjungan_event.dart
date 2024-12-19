import 'package:freezed_annotation/freezed_annotation.dart';

part 'selfie_kunjungan_event.freezed.dart';

@freezed
class SelfieKunjunganEvent with _$SelfieKunjunganEvent {
  const factory SelfieKunjunganEvent.started() = _Started;
  const factory SelfieKunjunganEvent.checkin(
    String latitude,
    String longitude,
    String base64Image,
    String kunjunganId,
  ) = _Checkin;
}
