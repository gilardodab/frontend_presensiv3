import '../../../../data/models/response/callplan_response_model.dart';

abstract class CallPlanState {}

class CallPlanInitial extends CallPlanState {}

class CallPlanLoadingState extends CallPlanState {}

class CallPlanLoadedState extends CallPlanState {
  final List<CallPlanModel> callPlans;
  CallPlanLoadedState({required this.callPlans});
}

class CallPlanErrorState extends CallPlanState {
  final String errorMessage;
  CallPlanErrorState({required this.errorMessage});
}

class CallPlanCreatedState extends CallPlanState {}

class CallPlanUpdatedState extends CallPlanState {}

class CallPlanDeletedState extends CallPlanState {}
