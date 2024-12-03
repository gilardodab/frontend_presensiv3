import 'package:equatable/equatable.dart';
import '../../../../data/models/response/user_response_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserData extends UserEvent {}

class UserDataFetched extends UserEvent {
  final UserResponseModel userResponse;

  const UserDataFetched({required this.userResponse});

  @override
  List<Object?> get props => [userResponse];
}

class UserDataFetchFailed extends UserEvent {
  final String error;

  const UserDataFetchFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
