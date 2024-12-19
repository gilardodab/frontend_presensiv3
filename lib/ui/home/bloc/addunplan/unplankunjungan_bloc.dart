import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/datasources/kunjungan_remote_datasource.dart';

import '../../../../data/models/request/selfie_unplan_request_model.dart';
import 'unplankunjungan_event.dart';
import 'unplankunjungan_state.dart';



class UnplanKunjunganBloc extends Bloc<UnplanKunjunganEvent, UnplanKunjunganState> {
  final KunjunganRemoteDatasource datasource;

  UnplanKunjunganBloc(this.datasource) : super(const UnplanKunjunganState.initial()) {
    on<UnplanKunjunganEvent>((event, emit) async {
      await event.when(
        started: () async {
          emit(const UnplanKunjunganState.initial());
        },
        unplan: (latitude, longitude, base64Image) async {
          emit(const UnplanKunjunganState.loading());
          final requestModel = CheckinRequestUnplan(
            latitude: latitude,
            longitude: longitude,
            pictureBase64: base64Image,
          );
          final result = await datasource.unplan(requestModel);
          result.fold(
            (failure) => emit(UnplanKunjunganState.error(failure)),
            (success) => emit(UnplanKunjunganState.loaded(success)),
          );
        },
      );
    });
  }
}
