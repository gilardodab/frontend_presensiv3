import 'dart:convert';

class KunjunganResponseModel {
  List<Kunjungan>? kunjungan;

  KunjunganResponseModel({this.kunjungan});

  KunjunganResponseModel copyWith({
    List<Kunjungan>? kunjungan,
  }) =>
      KunjunganResponseModel(
        kunjungan: kunjungan ?? this.kunjungan,
      );

  factory KunjunganResponseModel.fromJson(String str) =>
      KunjunganResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KunjunganResponseModel.fromMap(Map<String, dynamic> json) =>
      KunjunganResponseModel(
        kunjungan: json['data'] == null
            ? []
            : List<Kunjungan>.from(
                json["data"]!.map((x) => Kunjungan.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "kunjungan": kunjungan == null
            ? []
            : List<dynamic>.from(kunjungan!.map((x) => x.toMap())),
      };
}

class Kunjungan {
  String? kunjunganId;
  String? employeesId;
  String? kunjunganTgl;
  String? timeIn;
  String? pictureIn;
  String? statusKunjungan;
  String? latitudeLongtitudeIn;
  String? information;
  String? callplanId;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Kunjungan({
    this.kunjunganId,
    this.employeesId,
    this.kunjunganTgl,
    this.timeIn,
    this.pictureIn,
    this.statusKunjungan,
    this.latitudeLongtitudeIn,
    this.information,
    this.callplanId,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Kunjungan copyWith({
    String? kunjunganId,
    String? employeesId,
    String? kunjunganTgl,
    String? timeIn,
    String? pictureIn,
    String? statusKunjungan,
    String? latitudeLongitudeIn,
    String? information,
    String? callplanId,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Kunjungan(
        kunjunganId: kunjunganId ?? this.kunjunganId,
        employeesId: employeesId ?? this.employeesId,
        kunjunganTgl: kunjunganTgl ?? this.kunjunganTgl,
        timeIn: timeIn ?? this.timeIn,
        pictureIn: pictureIn ?? this.pictureIn,
        statusKunjungan: statusKunjungan ?? this.statusKunjungan,
        latitudeLongtitudeIn: latitudeLongitudeIn ?? this.latitudeLongtitudeIn,
        information: information ?? this.information,
        callplanId: callplanId ?? this.callplanId,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Kunjungan.fromJson(String str) => Kunjungan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Kunjungan.fromMap(Map<String, dynamic> json) => Kunjungan(
        kunjunganId: json['kunjungan_id']?.toString(),  // Konversi ke String
        employeesId: json['employees_id']?.toString(),
        kunjunganTgl: json['kunjungan_tgl'],
        timeIn: json['time_in'],
        pictureIn: json['picture_in'],
        statusKunjungan: json['status_kunjungan'],
        latitudeLongtitudeIn: json['latitude_longtitude_in'],
        information: json['information'],
        callplanId: json['callplan_id']?.toString(),
        description: json['description'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        //create Map
        "kunjungan_id": kunjunganId,
        "employees_id": employeesId,
        "kunjungan_tgl": kunjunganTgl,
        "time_in": timeIn,
        "picture_in": pictureIn,
        "status_kunjungan": statusKunjungan,
        "latitude_longitude_in": latitudeLongtitudeIn,
        "information": information,
        "callplan_id": callplanId,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
