import 'package:equatable/equatable.dart';

import '../../../../data/models/response/presensi_response_model.dart';

abstract class PresensiState extends Equatable {
  const PresensiState();

  @override
  List<Object> get props => [];
}

class PresensiInitial extends PresensiState {}

class PresensiLoading extends PresensiState {}

class PresensiLoaded extends PresensiState {
  final PresensiResponseModel presensiResponse;

  const PresensiLoaded({required this.presensiResponse});
  @override
  List<Object> get props => [presensiResponse];
}

class PresensiError extends PresensiState {
  final String error;

  const PresensiError({required this.error});
  @override
  List<Object> get props => [error];
}

