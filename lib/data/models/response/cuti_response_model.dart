class CutiResponseModel {
  final List<Cuti> data;

  CutiResponseModel({required this.data});
}


class Employee {
  final int id;
  final String employeeCode;
  final String employeeEmail;
  final String employeeName;
  final int positionId;
  final int shiftId;
  final int buildingId;
  final String photo;
  final String createdAt;
  final String updatedAt;

  Employee({
    required this.id,
    required this.employeeCode,
    required this.employeeEmail,
    required this.employeeName,
    required this.positionId,
    required this.shiftId,
    required this.buildingId,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeCode: json['employees_code'],
      employeeEmail: json['employees_email'],
      employeeName: json['employees_name'],
      positionId: json['position_id'],
      shiftId: json['shift_id'],
      buildingId: json['building_id'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  
  //convert to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'employees_code': employeeCode,
        'employees_email': employeeEmail,
        'employees_name': employeeName,
        'position_id': positionId,
        'shift_id': shiftId,
        'building_id': buildingId,
        'photo': photo,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class Cuti {
  final int cutyId;
  final int employeesId;
  final String cutyStart;
  final String cutyEnd;
  final String dateWork;
  final int cutyTotal;
  final String cutyDescription;
  final String cutyStatus;
  final String createdAt;
  final String updatedAt;
  final Employee employee;

  Cuti({
    required this.cutyId,
    required this.employeesId,
    required this.cutyStart,
    required this.cutyEnd,
    required this.dateWork,
    required this.cutyTotal,
    required this.cutyDescription,
    required this.cutyStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.employee,
  });

  factory Cuti.fromJson(Map<String, dynamic> json) {
    return Cuti(
      cutyId: json['cuty_id'],
      employeesId: json['employees_id'],
      cutyStart: json['cuty_start'],
      cutyEnd: json['cuty_end'],
      dateWork: json['date_work'],
      cutyTotal: json['cuty_total'],
      cutyDescription: json['cuty_description'],
      cutyStatus: json['cuty_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      employee: Employee.fromJson(json['employees']),
    );
  }

  //convert to json
  Map<String, dynamic> toJson() => {
        'cuty_id': cutyId,
        'employees_id': employeesId,
        'cuty_start': cutyStart,
        'cuty_end': cutyEnd,
        'date_work': dateWork,
        'cuty_total': cutyTotal,
        'cuty_description': cutyDescription,
        'cuty_status': cutyStatus,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'employees': employee.toJson(),
      };
}
