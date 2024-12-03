import 'package:equatable/equatable.dart';
import 'package:frontend_presensiv3/data/models/response/riwayatpresensi_response_model.dart';

abstract class RiwayatPresensiEvent extends Equatable {
  const RiwayatPresensiEvent();

  @override
  List<Object> get props => [];
}

class FetchRiwayatPresensiEvent extends RiwayatPresensiEvent {}

class RiwayatPresensiFetched extends RiwayatPresensiEvent {
  final RiwayatPresensiResponse riwayatPresensiResponse;

  const RiwayatPresensiFetched({required this.riwayatPresensiResponse});

  @override
  List<Object> get props => [riwayatPresensiResponse];
}

// Perubahan nama untuk menghindari bentrok dengan state
class RiwayatPresensiErrorEvent extends RiwayatPresensiEvent {
  final String error;

  const RiwayatPresensiErrorEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateRiwayatPresensiEvent extends RiwayatPresensiEvent {
  final int presenceId;
  final int presentId;
  final String? information;

  UpdateRiwayatPresensiEvent({required this.presenceId, required this.presentId, this.information});

  @override
  List<Object> get props => [presenceId, presentId, information ?? ''];
}

