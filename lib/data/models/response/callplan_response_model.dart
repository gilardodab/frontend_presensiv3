import 'dart:convert';

import 'package:intl/intl.dart';

class CallPlanResponseModel {
  final String? message;
  final List<CallPlan>? data;

  CallPlanResponseModel({this.message, this.data});

  // Now expecting Map<String, dynamic> directly
  factory CallPlanResponseModel.fromMap(Map<String, dynamic> json) =>
      CallPlanResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CallPlan>.from(json["data"].map((x) => CallPlan.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}


class CallPlan {
  final int? callplanId;
  final int? employeesId;
  final String? tanggalCp;
  final String? namaOutlet;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;


    CallPlan({
    this.callplanId,
    this.employeesId,
    this.tanggalCp,
    this.namaOutlet,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
  

  factory CallPlan.fromJson(String str) =>
      CallPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CallPlan.fromMap(Map<String, dynamic> json) => CallPlan(
        callplanId: json['callplan_id'],
        employeesId: json['employees_id'],
        tanggalCp: json['tanggal_cp'],
        namaOutlet: json['nama_outlet'],
        description: json['description'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  // Map<String, dynamic> toMap() => {
  //       "callplan_id": callplanId,
  //       "employees_id": employeesId,
  //       "tanggal_cp": tanggalCp,
  //       "nama_outlet": namaOutlet,
  //       "description": description,
  //       "created_at": createdAt?.toIso8601String(),
  //       "updated_at": updatedAt?.toIso8601String(),
  //     };
    Map<String, dynamic> toMap() {
    // Format tanggalCp (String or DateTime) to 'd-M-y'
    String? formattedTanggalCp = tanggalCp != null
        ? DateFormat('d-M-y').format(DateTime.parse(tanggalCp!)) // If it's a String
        : null;
    return {
      "callplan_id": callplanId,
      "employees_id": employeesId,
      "tanggal_cp": formattedTanggalCp,  // Use the formatted date
      "nama_outlet": namaOutlet,
      "description": description,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}
