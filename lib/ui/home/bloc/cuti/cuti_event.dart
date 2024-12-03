import 'package:equatable/equatable.dart';
import '../../../../data/models/response/cuti_response_model.dart';

abstract class CutiEvent extends Equatable {
  const CutiEvent();
  
  @override
  List<Object> get props => [];
}

class FetchCutiEvent extends CutiEvent {}

class AddCutiEvent extends CutiEvent {
  final Cuti cuti;

  const AddCutiEvent(this.cuti);

  @override
  List<Object> get props => [cuti];
}

class EditCutiEvent extends CutiEvent {
  final int id;
  final Cuti cuti;

  const EditCutiEvent(this.id, this.cuti);

  @override
  List<Object> get props => [id, cuti];
}

class DeleteCutiEvent extends CutiEvent {
  final int id;

  const DeleteCutiEvent(this.id);

  @override
  List<Object> get props => [id];
}
