class AddPresensiResponseModel {
  final String status;
  final String message;
  final dynamic data;

  AddPresensiResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory AddPresensiResponseModel.fromJson(Map<String, dynamic> json) {
    return AddPresensiResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
