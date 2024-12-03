import 'package:equatable/equatable.dart';
import '../../../../data/models/response/user_response_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserDataFetched extends UserState {
  final UserResponseModel userResponse;

  const UserDataFetched({required this.userResponse});

  @override
  List<Object?> get props => [userResponse];
}

class UserLoadFailure extends UserState {
  final String error;

  const UserLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
