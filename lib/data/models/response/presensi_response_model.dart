import 'dart:convert';

// Model class for the response
class PresensiResponseModel {
  String? message;
  List<PresensiData>? data;

  // Constructor
  PresensiResponseModel({this.message, this.data});

  // Updated fromJson method to handle Map<String, dynamic> (as returned by Dio)
  factory PresensiResponseModel.fromJson(Map<String, dynamic> json) =>
      PresensiResponseModel.fromMap(json);

  String toJson() => json.encode(toMap());

  factory PresensiResponseModel.fromMap(Map<String, dynamic> json) =>
      PresensiResponseModel(
        message: json["status"],
        data: json["data"] != null
            ? List<PresensiData>.from(json["data"].map((x) => PresensiData.fromMap(x)))
            : null,
      );

  Map<String, dynamic> toMap() => {
        "status": message,
        "data": data?.map((x) => x.toMap()).toList(),
      };
}

// Model class for the 'data' object
class PresensiData {
  final int presenceId;
  final int employeesId;
  final String presenceDate;
  final String timeIn;
  final String timeOut;
  final String pictureIn;
  final String? pictureOut;
  final String? information;

  PresensiData({
    required this.presenceId,
    required this.employeesId,
    required this.presenceDate,
    required this.timeIn,
    required this.timeOut,
    required this.pictureIn,
    this.pictureOut,
    this.information,
  });

  // fromMap method to convert Map<String, dynamic> to PresensiData object
  factory PresensiData.fromMap(Map<String, dynamic> json) => PresensiData(
    presenceId: json['presence_id'],
    employeesId: json['employees_id'],
    presenceDate: json['presence_date'],
    timeIn: json['time_in'],
    timeOut: json['time_out'],
    pictureIn: json['picture_in'],
    pictureOut: json['picture_out'],
    information: json['information'],
  );

  // toMap method to convert PresensiData object to Map<String, dynamic>
  Map<String, dynamic> toMap() => {
    'presence_id': presenceId,
    'employees_id': employeesId,
    'presence_date': presenceDate,
    'time_in': timeIn,
    'time_out': timeOut,
    'picture_in': pictureIn,
    'picture_out': pictureOut,
    'information': information,
  };
}
