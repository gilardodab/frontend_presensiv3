import 'package:equatable/equatable.dart';
import '../../../../data/models/response/cuti_response_model.dart';

abstract class CutiState extends Equatable {
  const CutiState();

  @override
  List<Object> get props => [];
}

class CutiInitialState extends CutiState {}

class CutiLoadingState extends CutiState {}

class CutiLoadedState extends CutiState {
  final List<Cuti> cutiList;
  
  const CutiLoadedState({required this.cutiList});
  
  @override
  List<Object> get props => [cutiList];
}

class CutiSuccessState extends CutiState {
  final String message;
  
  const CutiSuccessState(this.message);
  
  @override
  List<Object> get props => [message];
}

class CutiErrorState extends CutiState {
  final String errorMessage;
  
  const CutiErrorState(this.errorMessage);
  
  @override
  List<Object> get props => [errorMessage];
}
