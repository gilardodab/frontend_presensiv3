import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_presensiv3/data/models/response/cuti_response_model.dart';

import '../../../../data/datasources/cuti_remote_datasource.dart';

part 'cuti_event.dart';
part 'cuti_state.dart';
part 'cuti_bloc.freezed.dart';

class CutiBloc extends Bloc<CutiEvent, CutiState> {
  final CutiRemoteDataSource cutiDataSource;

  CutiBloc(this.cutiDataSource) : super(const _Initial()) {
    // on<FetchCutiEvent>((event, emit) async {
    //   emit(const _Loading());
    //   final result = await cutiDataSource.fetchCutiData(event.fromDate, event.toDate);
    //     result.fold(
    //       (message) => emit(_Error(message)),
    //     (cutiResponse) {
    //       if (cutiResponse.data == null || cutiResponse.data!.isEmpty) {
    //         emit(const _Empty());
    //       } else {
    //         emit (_Loaded(cutiResponse.data!));
    //       }
    //     },
    //     );
    //   });

      on<FetchCutiEventBulan>((event, emit) async {
      emit(const _Loading());
      final result = await cutiDataSource.fetchCutiDataBulan();
        result.fold(
          (message) => emit(_Error(message)),
        (cutiResponse) {
          if (cutiResponse.data == null || cutiResponse.data!.isEmpty) {
            emit(const _Empty());
          } else {
            emit (_Loaded(cutiResponse.data!));
          }
        },
        );
      });
    on<AddCutiEvent>((event, emit) async {
     emit(const _Loading());
      final result = await cutiDataSource.addCuti(event.cuti);
      result.fold(
        (message) => emit(_Error(message)),
        (_) => emit(const _Added('Cuti berhasil ditambahkan')),
      );
    });

    on<EditCutiEvent>((event, emit) async {
      emit(const _Loading());
      final result = await cutiDataSource.editCuti(event.cuti);
      result.fold(
        (message) => emit(_Error(message)),
        (_) => emit(const _Success('Cuti berhasil diedit')),
      );
    });

    on<DeleteCutiEvent>((event, emit) async {
      emit(const _Loading());
      final result = await cutiDataSource.deleteCuti(event.cuti);
      result.fold(
        (message) => emit(_Error(message)),
        (_) => emit(const _Success('Cuti berhasil dihapus')),
      );
    });
  }
}
