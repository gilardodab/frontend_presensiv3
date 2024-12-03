import 'package:meta/meta.dart';

import '../../../../data/models/response/add_presensi_response_model.dart';

@immutable
abstract class AddPresensiState {}

class AddPresensiInitialState extends AddPresensiState {}

class AddPresensiLoadingState extends AddPresensiState {}

class AddPresensiSuccessState extends AddPresensiState {
  final AddPresensiResponseModel response;

  AddPresensiSuccessState(this.response);
}

class AddPresensiErrorState extends AddPresensiState {
  final String errorMessage;

  AddPresensiErrorState(this.errorMessage);
}
