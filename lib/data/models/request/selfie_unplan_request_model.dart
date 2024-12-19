import 'dart:convert';

class CheckinRequestUnplan {
  final String? latitude;
  final String? longitude;
  final String? pictureBase64;  // Corrected name for the picture property

  CheckinRequestUnplan({
    this.latitude,
    this.longitude,
    this.pictureBase64,
  });

  factory CheckinRequestUnplan.fromJson(String str) =>
      CheckinRequestUnplan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckinRequestUnplan.fromMap(Map<String, dynamic> json) =>
      CheckinRequestUnplan(
        latitude: json["latitude"],
        longitude: json["longitude"],
        pictureBase64: json["picture"],  // Map the field correctly
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "picture": pictureBase64,  // Map the field correctly
      };
}
