

import 'package:equatable/equatable.dart';

import '../../../../data/models/response/presensi_response_model.dart';

abstract class PresensiEvent extends Equatable {
  const PresensiEvent();
    @override
  List<Object?> get props => [];
}

class FetchPresensiData extends PresensiEvent {}

class PresensiDataFetched extends PresensiEvent {
  final PresensiResponseModel presensiResponseModel;

  const PresensiDataFetched(this.presensiResponseModel);

  @override
  List<Object?> get props => [presensiResponseModel];

}

class PresensiDataError extends PresensiEvent {
  final String message;

  const PresensiDataError(this.message);

  @override
  List<Object?> get props => [message];
}