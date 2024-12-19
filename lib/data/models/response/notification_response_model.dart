import 'dart:convert';

class NotificationResponseModel {
  String? status;
  List<Broadcast>? notifications;

  NotificationResponseModel({
    this.status,
    this.notifications,
  });

  factory NotificationResponseModel.fromJson(String str) =>
      NotificationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationResponseModel.fromMap(Map<String, dynamic> json) =>
      NotificationResponseModel(
        status: json["status"], // Menambahkan field status
        notifications: json["data"] == null
            ? []
            : List<Broadcast>.from(
                json["data"]!.map((x) => Broadcast.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toMap())),
      };
}

class Broadcast {
  int? id;
  int? employeeId; // Menambahkan field employee_id
  String? title;
  String? body;
  int? isRead; // Mengubah isRead menjadi tipe int
  DateTime? createdAt;
  DateTime? updatedAt;

  Broadcast({
    this.id,
    this.employeeId,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory Broadcast.fromJson(String str) => Broadcast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Broadcast.fromMap(Map<String, dynamic> json) => Broadcast(
        id: json["id"],
        employeeId: json["employee_id"], // Mengambil employee_id
        title: json["title"],
        body: json["body"],
        isRead: json["is_read"], // Menggunakan int untuk is_read
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "employee_id": employeeId, // Menambahkan employee_id
        "title": title,
        "body": body,
        "is_read": isRead, // Menyimpan is_read sebagai int
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
