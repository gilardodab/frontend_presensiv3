class CallPlanModel {
  final int callplanId;
  final int employeesId;
  final String tanggalCp;
  final String namaOutlet;
  final String description;
  final String createdAt;
  final String updatedAt;

  CallPlanModel({
    required this.callplanId,
    required this.employeesId,
    required this.tanggalCp,
    required this.namaOutlet,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

factory CallPlanModel.fromJson(Map<String, dynamic> json) {
  return CallPlanModel(
    callplanId: json['callplan_id'],
    employeesId: json['employees_id'],
    tanggalCp: json['tanggal_cp'],
    namaOutlet: json['nama_outlet'],
    description: json['description'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}


  Map<String, dynamic> toJson() {
    return {
      'callplan_id': callplanId,
      'employees_id': employeesId,
      'tanggal_cp': tanggalCp,
      'nama_outlet': namaOutlet,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
