import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/data/models/response/cuti_response_model.dart';
import '../../../../data/datasources/cuti_remote_datasource.dart';
import 'cuti_event.dart';
import 'cuti_state.dart';

class CutiBloc extends Bloc<CutiEvent, CutiState> {
  final CutiDataSource cutiDataSource;

  CutiBloc({required this.cutiDataSource}) : super(CutiInitialState()) {
    on<FetchCutiEvent>(_fetchCutiData);
    on<AddCutiEvent>(_addCuti);
    on<EditCutiEvent>(_editCuti);
    on<DeleteCutiEvent>(_deleteCuti);
  }

  // Fetch all cuti data
  void _fetchCutiData(FetchCutiEvent event, Emitter<CutiState> emit) async {
    emit(CutiLoadingState());
    try {
      final cutiList = await cutiDataSource.fetchCutiData();
      emit(CutiLoadedState(cutiList: cutiList));
    } catch (e) {
      emit(CutiErrorState('Failed to load cuti: $e'));
    }
  }

  // Add a new cuti
  void _addCuti(AddCutiEvent event, Emitter<CutiState> emit) async {
    emit(CutiLoadingState());
    try {
      await cutiDataSource.addCuti(event.cuti);
      emit(CutiSuccessState('Cuti added successfully'));
      add(FetchCutiEvent()); // Refresh data after adding
    } catch (e) {
      emit(CutiErrorState('Failed to add cuti: $e'));
    }
  }

  // Edit an existing cuti
  void _editCuti(EditCutiEvent event, Emitter<CutiState> emit) async {
    emit(CutiLoadingState());
    try {
      await cutiDataSource.editCuti(event.id, event.cuti);
      emit(CutiSuccessState('Cuti updated successfully'));
      add(FetchCutiEvent()); // Refresh data after editing
    } catch (e) {
      emit(CutiErrorState('Failed to update cuti: $e'));
    }
  }

  // Delete a cuti
  void _deleteCuti(DeleteCutiEvent event, Emitter<CutiState> emit) async {
    emit(CutiLoadingState());
    try {
      await cutiDataSource.deleteCuti(event.id);
      emit(CutiSuccessState('Cuti deleted successfully'));
      add(FetchCutiEvent()); // Refresh data after deleting
    } catch (e) {
      emit(CutiErrorState('Failed to delete cuti: $e'));
    }
  }
}
