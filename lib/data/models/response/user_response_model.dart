import 'dart:convert';

class UserResponseModel {
  UserResponseModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  // Update fromJson to accept a Map<String, dynamic> instead of a String
  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel.fromMap(json);

  // Method to convert to JSON string
  String toJson() => json.encode(toMap());

  // Map the response to the model
  factory UserResponseModel.fromMap(Map<String, dynamic> json) => UserResponseModel(
        message: json["status"],
        data: json["data"] != null ? Data.fromMap(json["data"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "status": message,
        "data": data?.toMap(),
      };
}

class Data {
  Data({
    this.id,
    this.employeesCode,
    this.employeesEmail,
    this.employeesName,
    this.positionId,
    this.shiftId,
    this.buildingId,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.shift,
    this.building,
    this.position,
  });

  int? id;
  String? employeesCode;
  String? employeesEmail;
  String? employeesName;
  int? positionId;
  int? shiftId;
  int? buildingId;
  String? photo;
  String? createdAt;
  String? updatedAt;
  Shift? shift;
  Building? building;
  Position? position;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        employeesCode: json["employees_code"],
        employeesEmail: json["employees_email"],
        employeesName: json["employees_name"],
        positionId: json["position_id"],
        shiftId: json["shift_id"],
        buildingId: json["building_id"],
        photo: json["photo"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        shift: json["shift"] != null ? Shift.fromMap(json["shift"]) : null,
        building: json["building"] != null ? Building.fromMap(json["building"]) : null,
        position: json["position"] != null ? Position.fromMap(json["position"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "employees_code": employeesCode,
        "employees_email": employeesEmail,
        "employees_name": employeesName,
        "position_id": positionId,
        "shift_id": shiftId,
        "building_id": buildingId,
        "photo": photo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "shift": shift?.toMap(),
        "building": building?.toMap(),
        "position": position?.toMap(),
      };
}

class Shift {
  Shift({
    this.shiftId,
    this.shiftName,
    this.timeIn,
    this.timeOut,
    this.createdAt,
    this.updatedAt,
  });

  int? shiftId;
  String? shiftName;
  String? timeIn;
  String? timeOut;
  String? createdAt;
  String? updatedAt;

  factory Shift.fromMap(Map<String, dynamic> json) => Shift(
        shiftId: json["shift_id"],
        shiftName: json["shift_name"],
        timeIn: json["time_in"],
        timeOut: json["time_out"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "shift_id": shiftId,
        "shift_name": shiftName,
        "time_in": timeIn,
        "time_out": timeOut,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Building {
  Building({
    this.buildingId,
    this.code,
    this.name,
    this.address,
    this.latitudeLongitude,
    this.radius,
    this.createdAt,
    this.updatedAt,
  });

  int? buildingId;
  String? code;
  String? name;
  String? address;
  String? latitudeLongitude;
  int? radius;
  String? createdAt;
  String? updatedAt;

  factory Building.fromMap(Map<String, dynamic> json) => Building(
        buildingId: json["building_id"],
        code: json["code"],
        name: json["name"],
        address: json["address"],
        latitudeLongitude: json["latitude_longtitude"],
        radius: json["radius"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "building_id": buildingId,
        "code": code,
        "name": name,
        "address": address,
        "latitude_longtitude": latitudeLongitude,
        "radius": radius,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Position {
  Position({
    this.positionId,
    this.positionName,
    this.createdAt,
    this.updatedAt,
  });

  int? positionId;
  String? positionName;
  String? createdAt;
  String? updatedAt;

  factory Position.fromMap(Map<String, dynamic> json) => Position(
        positionId: json["position_id"],
        positionName: json["position_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "position_id": positionId,
        "position_name": positionName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
