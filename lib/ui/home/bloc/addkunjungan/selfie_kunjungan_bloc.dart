import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/datasources/kunjungan_remote_datasource.dart';
import '../../../../data/models/request/selfie_kunjungan_request_model.dart';
import 'selfie_kunjugan_state.dart';
import 'selfie_kunjungan_event.dart';



class SelfieKunjunganBloc extends Bloc<SelfieKunjunganEvent, SelfieKunjunganState> {
  final KunjunganRemoteDatasource datasource;

  SelfieKunjunganBloc(this.datasource) : super(const SelfieKunjunganState.initial()) {
    on<SelfieKunjunganEvent>((event, emit) async {
      await event.when(
        started: () async {
          emit(const SelfieKunjunganState.initial());
        },
        checkin: (latitude, longitude, base64Image, kunjunganId) async {
          emit(const SelfieKunjunganState.loading());
          final requestModel = CheckinRequestKunjungan(
            latitude: latitude,
            longitude: longitude,
            kunjunganId: kunjunganId,
            pictureBase64: base64Image,
          );
          final result = await datasource.checkin(requestModel);
          result.fold(
            (failure) => emit(SelfieKunjunganState.error(failure)),
            (success) => emit(SelfieKunjunganState.loaded(success)),
          );
        },
      );
    });
  }
}
