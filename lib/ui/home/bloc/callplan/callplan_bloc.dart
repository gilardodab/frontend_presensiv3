import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/datasources/callplan_remote_datasource.dart';
import '../../../../data/models/response/callplan_response_model.dart';

part 'callplan_bloc.freezed.dart';
part 'callplan_event.dart';
part 'callplan_state.dart';

class CallPlanBloc extends Bloc<CallPlanEvent, CallPlanState> {
  final CallPlanRemoteDataSource callPlanRemoteDataSource;

  // Constructor
  CallPlanBloc(this.callPlanRemoteDataSource) : super(const _Initial()) {
    
    // Event handler for fetching call plans
    on<_GetCallPlan>((event, emit) async {
      emit(const _Loading());
      final result = await callPlanRemoteDataSource.loadCallPlans(event.fromDate, event.toDate);
      result.fold(
        (message) => emit(_Error(message)),
        (callPlanResponse) {
          if (callPlanResponse.data == null || callPlanResponse.data!.isEmpty) {
            emit(const _Empty());
          } else {
            emit(_Loaded(callPlanResponse.data!));
          }
        },
      );
    });
    on<_GetCallPlanBulan>((event, emit) async {
      emit(const _Loading());
      final result = await callPlanRemoteDataSource.loadCallPlansBulan();
      result.fold(
        (message) => emit(_Error(message)),
        (callPlanResponse) {
          if (callPlanResponse.data == null || callPlanResponse.data!.isEmpty) {
            emit(const _Empty());
          } else {
            emit(_Loaded(callPlanResponse.data!));
          }
        },
      );
    });

    // Event handler for updating a call plan
    on<_UpdateCallPlan>((event, emit) async {
      emit(const _Loading());
      final result = await callPlanRemoteDataSource.updateCallPlan(event.callPlan);
      result.fold(
        (message) => emit(_Error(message)),
        (l) => emit(const _Success('CallPlan Berhasil Di Ubah')),
      );
    });

    // Event handler for deleting a call plan
    on<_DeleteCallPlan>((event, emit) async {
      emit(const _Loading());
      final result = await callPlanRemoteDataSource.deleteCallPlan(event.callPlan);
      result.fold(
        (message) => emit(_Error(message)),
        (_) => emit(const _Success('CallPlan berhasil diHapus')),
      );
    });

    on<_AddCallPlan>((event, emit) async {
     emit(const _Loading());
      final result = await callPlanRemoteDataSource.addCallPlan(event.callPlan); // Assuming addCallPlan exists in your data source
      result.fold(
        (message) => emit(_Error(message)),
        (_) => emit(const _Added('Call Plan Berhasil Ditambahkan!')),
      );
    });
  }
}
