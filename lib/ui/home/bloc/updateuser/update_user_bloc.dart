
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/user_remote_datasource.dart';
import '../../../../data/models/response/update_user_model.dart';
import '../../../../data/models/response/user_response_model.dart';

part 'update_user_state.dart';
part 'update_user_event.dart';
part 'update_user_bloc.freezed.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRemoteDatasource _userRemoteDatasource;
  UpdateUserBloc(this._userRemoteDatasource) : super(const _Initial()) {
    on<_UpdateUser>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await _userRemoteDatasource.updateUser(event.user);
        result.fold(
          (message) => emit(_Error(message)),
          (message) => emit(_Success(message as String)),
        );
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}