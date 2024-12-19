import 'dart:convert';

class CutiResponseModel {
  final String? message;
  final List<Cuti>? data;
  CutiResponseModel({this.message, this.data});

  factory CutiResponseModel.fromMap(Map<String, dynamic> json) =>
      CutiResponseModel(
        message: json['message'],
        data: json["data"] == null
            ? []
            : List<Cuti>.from(json["data"].map((x) => Cuti.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

// class Employee {
//   final int? id;
//   final String? employeeCode;
//   final String? employeeEmail;
//   final String? employeeName;
//   final int? positionId;
//   final int? shiftId;
//   final int? buildingId;
//   final String? photo;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   Employee({
//     this.id,
//     this.employeeCode,
//     this.employeeEmail,
//     this.employeeName,
//     this.positionId,
//     this.shiftId,
//     this.buildingId,
//     this.photo,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Employee.fromMap(Map<String, dynamic> json) => Employee(
//         id: json['id'],
//         employeeCode: json['employees_code'],
//         employeeEmail: json['employees_email'],
//         employeeName: json['employees_name'],
//         positionId: json['position_id'],
//         shiftId: json['shift_id'],
//         buildingId: json['building_id'],
//         photo: json['photo'],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   //convert to json
//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'employees_code': employeeCode,
//         'employees_email': employeeEmail,
//         'employees_name': employeeName,
//         'position_id': positionId,
//         'shift_id': shiftId,
//         'building_id': buildingId,
//         'photo': photo,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }

class Cuti {
  final int? cutyId;
  final int? employeesId;
  final String? cutyStart;
  final String? cutyEnd;
  final String? dateWork;
  final int? cutyTotal;
  final String? cutyDescription;
  final String? cutyStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // final Employee? employee;

  Cuti({
    this.cutyId,
    this.employeesId,
    this.cutyStart,
    this.cutyEnd,
    this.dateWork,
    this.cutyTotal,
    this.cutyDescription,
    this.cutyStatus,
    this.createdAt,
    this.updatedAt,
    // this.employee,
  });

  factory Cuti.fromJson(String str) => Cuti.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cuti.fromMap(Map<String, dynamic> json) => Cuti(
        cutyId: json['cuty_id'],
        employeesId: json['employees_id'],
        cutyStart: json['cuty_start'],
        cutyEnd: json['cuty_end'],
        dateWork: json['date_work'],
        cutyTotal: json['cuty_total'],
        cutyDescription: json['cuty_description'],
        cutyStatus: json['cuty_status'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        // employee: Employee.fromJson(json['employees']),
      );

  //convert to json
  Map<String, dynamic> toMap() => {
        'cuty_id': cutyId,
        'employees_id': employeesId,
        'cuty_start': cutyStart,
        'cuty_end': cutyEnd,
        'date_work': dateWork,
        'cuty_total': cutyTotal,
        'cuty_description': cutyDescription,
        'cuty_status': cutyStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        // 'employees': employee?.toMap(),
      };
}
