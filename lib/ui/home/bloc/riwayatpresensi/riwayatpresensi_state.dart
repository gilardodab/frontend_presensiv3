import 'package:equatable/equatable.dart';
import '../../../../data/models/response/riwayatpresensi_response_model.dart';

abstract class RiwayatPresensiState extends Equatable {
  @override
  List<Object> get props => [];
}

class RiwayatPresensiInitial extends RiwayatPresensiState {}

class RiwayatPresensiLoading extends RiwayatPresensiState {}

class RiwayatPresensiLoaded extends RiwayatPresensiState {
  final RiwayatPresensiResponse riwayatPresensiResponse;
  RiwayatPresensiLoaded({required this.riwayatPresensiResponse});

  @override
  List<Object> get props => [riwayatPresensiResponse];
}

class RiwayatPresensiErrorState extends RiwayatPresensiState {
  final String error;

  RiwayatPresensiErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class RiwayatPresensiUpdated extends RiwayatPresensiState {
  final String message;

  RiwayatPresensiUpdated({required this.message});

  @override
  List<Object> get props => [message];
}

class RiwayatPresensiUpdateError extends RiwayatPresensiState {
  final String error;

  RiwayatPresensiUpdateError({required this.error});

  @override
  List<Object> get props => [error];
}
