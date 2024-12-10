import '../../../../data/models/response/callplan_response_model.dart';

abstract class CallPlanEvent {}

class LoadCallPlansEvent extends CallPlanEvent {
  final String fromDate;
  final String toDate;
  LoadCallPlansEvent({required this.fromDate, required this.toDate});
}

class CreateCallPlanEvent extends CallPlanEvent {
  final CallPlanModel callPlan;
  CreateCallPlanEvent({required this.callPlan});
}

class UpdateCallPlanEvent extends CallPlanEvent {
  final CallPlanModel callPlan;
  UpdateCallPlanEvent({required this.callPlan});
}

class DeleteCallPlanEvent extends CallPlanEvent {
  final int callPlanId;
  DeleteCallPlanEvent({required this.callPlanId});
}
