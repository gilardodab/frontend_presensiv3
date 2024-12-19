import 'dart:convert';

// Model class for the response
class HistoryBulananPresensiModel {
  final String? message;
  final List<HistoryBulananPresensi>? data;

  HistoryBulananPresensiModel({this.message, this.data});

  factory HistoryBulananPresensiModel.fromMap(Map<String, dynamic> json) =>
      HistoryBulananPresensiModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<HistoryBulananPresensi>.from(
                json["data"]!.map((x) => HistoryBulananPresensi.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class HistoryBulananPresensi {
  final int? presenceId;
  final String? employeesId;
  final String? presenceDate;
  final String? timeIn;
  final String? timeOut;
  final String? pictureIn;
  final String? pictureOut;
  final String? latitudeIn;
  final String? latitudeOut;
  final String? information;
  final int? presentId; 
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PresentStatus? presentStatus;

  HistoryBulananPresensi({
    this.presenceId,
    this.employeesId,
    this.presenceDate,
    this.timeIn,
    this.timeOut,
    this.pictureIn,
    this.pictureOut,
    this.latitudeIn,
    this.latitudeOut,
    this.information,
    this.presentId,
    this.presentStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryBulananPresensi.fromJson(String str) =>
      HistoryBulananPresensi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryBulananPresensi.fromMap(Map<String, dynamic> json) =>
      HistoryBulananPresensi(
        presenceId: json["presence_id"] != null ? int.tryParse(json["presence_id"].toString()) : null,
        employeesId: json["employees_id"]?.toString(),
        presenceDate: json["presence_date"],
        timeIn: json["time_in"]?.toString(),
        timeOut: json["time_out"]?.toString(),
        pictureIn: json["picture_in"]?.toString(),
        pictureOut: json["picture_out"]?.toString(),
        latitudeIn: json["latitude_longtitude_in"]?.toString(),
        latitudeOut: json["latitude_longtitude_out"]?.toString(),
        information: json["information"]?.toString(),
        presentId: json["present_id"] != null ? int.tryParse(json["present_id"].toString()) : null, // Parse presentId as int
        presentStatus: json["present_status"] != null
            ? PresentStatus.fromMap(json["present_status"]) // Parsing objek present_status ke objek Status
            : null,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "presence_id": presenceId,
        "employees_id": employeesId,
        "presence_date": presenceDate,
        "time_in": timeIn,
        "time_out": timeOut,
        "picture_in": pictureIn,
        "picture_out": pictureOut,
        "latitude_longtitude_in": latitudeIn,
        "latitude_longtitude_out": latitudeOut,
        "information": information,
        "present_id": presentId, 
        "present_status": presentStatus?.toMap(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PresentStatus {
  final int? presentId;  // ID status presensi
  final String? presentName;  // Nama status presensi (misalnya: "Hadir")
  final DateTime? createdAt; // Tanggal pembuatan status
  final DateTime? updatedAt; // Tanggal pembaruan status

  PresentStatus({
    this.presentId,
    this.presentName,
    this.createdAt,
    this.updatedAt,
  });

  // Fungsi untuk mengonversi Map ke objek Status
  factory PresentStatus.fromMap(Map<String, dynamic> json) => PresentStatus(
        presentId: json["present_id"],
        presentName: json["present_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  // Fungsi untuk mengonversi objek Status ke Map
  Map<String, dynamic> toMap() => {
        "present_id": presentId,
        "present_name": presentName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
