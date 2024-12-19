// // riwayatpresensi_bloc.dart

// import 'dart:io';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../data/datasources/riwayatpresensi_datasource.dart';
// import 'riwayatpresensi_event.dart' as riwayatpresensi_event;
// import 'riwayatpresensi_state.dart' as riwayatpresensi_state;

// class RiwayatPresensiBloc extends Bloc<
//     riwayatpresensi_event.RiwayatPresensiEvent,
//     riwayatpresensi_state.RiwayatPresensiState> {
//   final RiwayatPresensiRemoteDataSource riwayatPresensiRemoteDataSource;

//   RiwayatPresensiBloc({required this.riwayatPresensiRemoteDataSource})
//       : super(riwayatpresensi_state.RiwayatPresensiInitial()) {
//     on<riwayatpresensi_event.FetchRiwayatPresensiEvent>(_fetchRiwayatPresensiData);
//     on<riwayatpresensi_event.UpdateRiwayatPresensiEvent>(_updateRiwayatPresensiData);
//   }

//   Future<void> _fetchRiwayatPresensiData(
//       riwayatpresensi_event.FetchRiwayatPresensiEvent event,
//       Emitter<riwayatpresensi_state.RiwayatPresensiState> emit) async {
//     emit(riwayatpresensi_state.RiwayatPresensiLoading());
//     try {
//       final result =
//           await riwayatPresensiRemoteDataSource.fetchRiwayatPresensi();
//       result.fold(
//         (error) {
//           emit(riwayatpresensi_state.RiwayatPresensiErrorState(error: error));
//         },
//         (riwayatPresensiResponse) {
//           emit(riwayatpresensi_state.RiwayatPresensiLoaded(
//               riwayatPresensiResponse: riwayatPresensiResponse));
//         },
//       );
//     } catch (e) {
//       if (e is SocketException) {
//         emit(riwayatpresensi_state.RiwayatPresensiErrorState(
//             error: 'Koneksi internet tidak ada atau server sedang down.'));
//       } else {
//         emit(riwayatpresensi_state.RiwayatPresensiErrorState(
//             error: 'Unexpected error: $e'));
//       }
//     }
//   }

//   Future<void> _updateRiwayatPresensiData(
//       riwayatpresensi_event.UpdateRiwayatPresensiEvent event,
//       Emitter<riwayatpresensi_state.RiwayatPresensiState> emit) async {
//     emit(riwayatpresensi_state.RiwayatPresensiLoading());

//     try {
//       final result = await riwayatPresensiRemoteDataSource.updateRiwayat(
//         event.presenceId,
//         event.presentId,
//         event.information,
//       );

//       result.fold(
//         (error) {
//           emit(riwayatpresensi_state.RiwayatPresensiErrorState(
//             error: 'Server error, please try again.',
//           ));
//         },
//         (success) {
//           emit(riwayatpresensi_state.RiwayatPresensiUpdated(message: ''));
//         },
//       );
//     } catch (e) {
//       if (e is SocketException) {
//         emit(riwayatpresensi_state.RiwayatPresensiErrorState(
//             error: 'Koneksi internet tidak ada atau server sedang down.'));
//       } else {
//         emit(riwayatpresensi_state.RiwayatPresensiErrorState(
//             error: 'Unexpected error: $e'));
//       }
//     }
//   }
// }
