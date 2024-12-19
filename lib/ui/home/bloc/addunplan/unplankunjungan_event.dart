import 'package:freezed_annotation/freezed_annotation.dart';

part 'unplankunjungan_event.freezed.dart';

@freezed
class UnplanKunjunganEvent with _$UnplanKunjunganEvent {
  const factory UnplanKunjunganEvent.started() = _Started;
  const factory UnplanKunjunganEvent.unplan(
    String latitude,
    String longitude,
    String base64Image,
  ) = _Unplan;
}
