import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/resetpassword_remote_datasource.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';
part 'resetpassword_bloc.freezed.dart';

class ResetpasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordRemoteDataSource datasource;

  ResetpasswordBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_ResetPassword>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.resetPassword(event.password);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded()),
      );
    });
  }
}
