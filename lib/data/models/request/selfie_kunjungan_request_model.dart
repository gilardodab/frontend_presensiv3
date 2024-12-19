import 'dart:convert';

class CheckinRequestKunjungan {
  final String? latitude;
  final String? longitude;
  final String? kunjunganId;
  final String? pictureBase64;  // Corrected name for the picture property

  CheckinRequestKunjungan({
    this.latitude,
    this.longitude,
    this.kunjunganId,
    this.pictureBase64,
  });

  factory CheckinRequestKunjungan.fromJson(String str) =>
      CheckinRequestKunjungan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckinRequestKunjungan.fromMap(Map<String, dynamic> json) =>
      CheckinRequestKunjungan(
        latitude: json["latitude"],
        longitude: json["longitude"],
        kunjunganId: json["kunjungan_id"],
        pictureBase64: json["picture"],  // Map the field correctly
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "kunjungan_id": kunjunganId,
        "picture": pictureBase64,  // Map the field correctly
      };
}
