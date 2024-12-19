import 'package:bloc/bloc.dart';
import '../../../../data/datasources/user_remote_datasource.dart';
import 'user_event.dart' as user_event; // Alias for user_event
import 'user_state.dart' as user_state; // Alias for user_state

class UserBloc extends Bloc<user_event.UserEvent, user_state.UserState> {
  final UserRemoteDatasource userRemoteDatasource;

  UserBloc({required this.userRemoteDatasource}) : super(user_state.UserInitial()) {
    on<user_event.FetchUserData>(_onFetchUserData);  // Register the event handler
  }

  // Event handler for FetchUserData
  Future<void> _onFetchUserData(
      user_event.FetchUserData event, Emitter<user_state.UserState> emit) async {
    emit(user_state.UserLoading()); // Emit loading state

    try {
      final result = await userRemoteDatasource.getUser();

      result.fold(
        (error) {
          emit(user_state.UserLoadFailure(error: error)); // Emit failure state
        },
        (userResponse) {
          emit(user_state.UserDataFetched(userResponse: userResponse)); // Emit success state
        },
      );
    } catch (e) {
      emit(user_state.UserLoadFailure(error: 'Unexpected error: $e')); // Emit failure on unexpected error
    }
  }
}
