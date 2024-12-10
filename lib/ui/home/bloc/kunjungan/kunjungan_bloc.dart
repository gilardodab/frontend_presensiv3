import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_presensiv3/data/datasources/kunjungan_remote_datasource.dart';
import 'package:frontend_presensiv3/data/models/response/kunjungan_response_model.dart';

part 'kunjungan_bloc.freezed.dart';
part 'kunjungan_state.dart';
part 'kunjungan_event.dart';

class KunjunganBloc extends Bloc<KunjunganEvent, KunjunganState> {
  final KunjunganRemoteDatasource datasource;
  KunjunganBloc(
    this.datasource,
  ) : super(_Initial()){
    on<_Kunjungan>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.fetchKunjungan();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
