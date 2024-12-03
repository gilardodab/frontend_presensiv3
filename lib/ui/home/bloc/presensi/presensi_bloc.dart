import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/datasources/presensi_remote_datasource.dart';
import 'presensi_event.dart' as presensi_event;
import 'presensi_state.dart' as presensi_state;


class PresensiBloc extends Bloc<presensi_event.PresensiEvent, presensi_state.PresensiState> {
  final PresensiRemoteDataSource presensiRemoteDataSource;

  PresensiBloc({required this.presensiRemoteDataSource}) : super(presensi_state.PresensiInitial()) {
    on<presensi_event.FetchPresensiData>(_fetchPresensiData);
  }

  Future<void> _fetchPresensiData(presensi_event.FetchPresensiData event, Emitter<presensi_state.PresensiState> emit) async {
    emit(presensi_state.PresensiLoading());

    try {
      final result = await presensiRemoteDataSource.getPresensi();
      result.fold(
        (error) {
          emit(presensi_state.PresensiError(error: error));
        },
        (presensiResponse) {
          emit(presensi_state.PresensiLoaded(presensiResponse: presensiResponse));
        },
      );
    } catch (e) {
      emit(presensi_state.PresensiError(error: 'Unexpected error: $e'));
    }
  }
}