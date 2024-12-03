
import 'dart:convert';

class RiwayatPresensiResponse {
  final String status;
  final List<RiwayatPresensi> data;
  final String message;

  RiwayatPresensiResponse({
    required this.status,
    required this.data,
    required this.message,
  });


  factory RiwayatPresensiResponse.fromJson(String str) =>
      RiwayatPresensiResponse.fromMap(json.decode(str));
      

  String toJson() => json.encode(toMap());

  factory RiwayatPresensiResponse.fromMap(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<RiwayatPresensi> presensiList =
        list.map((i) => RiwayatPresensi.fromJson(i)).toList();

    return RiwayatPresensiResponse(
      status: json['status'],
      data: presensiList,
      message: json['message'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.map((x) => x.toMap()).toList(),
      'message': message,
    };
  }
}


   


class RiwayatPresensi {
  final int presenceId;
  final int employeesId;
  final String presenceDate;
  final String timeIn;
  final String timeOut;
  final String? pictureIn;
  final String? pictureOut;
  final int presentId;
  final String latitudeLongitudeIn;
  final String? latitudeLongitudeOut;
  final String? information;
  final String createdAt;
  final String updatedAt;
  final PresentStatus presentStatus;

  RiwayatPresensi({
    required this.presenceId,
    required this.employeesId,
    required this.presenceDate,
    required this.timeIn,
    required this.timeOut,
    this.pictureIn,
    this.pictureOut,
    required this.presentId,
    required this.latitudeLongitudeIn,
    this.latitudeLongitudeOut,
    this.information,
    required this.createdAt,
    required this.updatedAt,
    required this.presentStatus,
  });

  factory RiwayatPresensi.fromJson(Map<String, dynamic> json) {
    return RiwayatPresensi(
      presenceId: json['presence_id'],
      employeesId: json['employees_id'],
      presenceDate: json['presence_date'],
      timeIn: json['time_in'],
      timeOut: json['time_out'],
      pictureIn: json['picture_in'],
      pictureOut: json['picture_out'],
      presentId: json['present_id'],
      latitudeLongitudeIn: json['latitude_longtitude_in'],
      latitudeLongitudeOut: json['latitude_longtitude_out'],
      information: json['information'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      presentStatus: PresentStatus.fromJson(json['present_status']),
    );
  }

  Map<String, dynamic> toMap() => {
        'presence_id': presenceId,
        'employees_id': employeesId,
        'presence_date': presenceDate,
        'time_in': timeIn,
        'time_out': timeOut,
        'picture_in': pictureIn,
        'picture_out': pictureOut,
        'present_id': presentId,
        'latitude_longtitude_in': latitudeLongitudeIn,
        'latitude_longtitude_out': latitudeLongitudeOut,
        'information': information,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'present_status': presentStatus.toMap(),
      };
}

class PresentStatus {
  final int presentId;
  final String presentName;

  PresentStatus({required this.presentId, required this.presentName});

  factory PresentStatus.fromJson(Map<String, dynamic> json) {
    return PresentStatus(
      presentId: json['present_id'],
      presentName: json['present_name'],
    );
  }

  Map<String, dynamic> toMap() => {
        'present_id': presentId,
        'present_name': presentName,
      };
}

  
        



