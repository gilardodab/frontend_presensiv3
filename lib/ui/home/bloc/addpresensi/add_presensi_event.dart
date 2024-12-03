import 'package:meta/meta.dart';

@immutable
abstract class AddPresensiEvent {}

class AddPresensiRecordEvent extends AddPresensiEvent {
  final String latitude;
  final String longitude;
  final String pictureBase64;

  AddPresensiRecordEvent({
    required this.latitude,
    required this.longitude,
    required this.pictureBase64,
  });
}
