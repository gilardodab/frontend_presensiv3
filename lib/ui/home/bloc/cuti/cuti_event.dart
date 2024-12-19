part of 'cuti_bloc.dart';

@freezed
class CutiEvent with _$CutiEvent {
  const factory CutiEvent.fetchCutiEvent(String fromDate, String toDate)= FetchCutiEvent;
  const factory CutiEvent.fetchCutiEventBulan() = FetchCutiEventBulan;
  const factory CutiEvent.addCutiEvent(Cuti cuti) = AddCutiEvent;
  const factory CutiEvent.editCutiEvent(Cuti cuti) = EditCutiEvent;
  const factory CutiEvent.deleteCutiEvent(Cuti cuti) = DeleteCutiEvent;
}