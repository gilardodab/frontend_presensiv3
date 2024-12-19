part of 'resetpassword_bloc.dart';

@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.started() = _Started;
  const factory ResetPasswordEvent.resetPassword({
    required String password,
  }) = _ResetPassword;
}
