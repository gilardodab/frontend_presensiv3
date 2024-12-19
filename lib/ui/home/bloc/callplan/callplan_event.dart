// callplan_event.dart
part of 'callplan_bloc.dart';

@freezed
class CallPlanEvent with _$CallPlanEvent {
  const factory CallPlanEvent.getCallPlanBulan() = _GetCallPlanBulan;
  const factory CallPlanEvent.getCallPlan(String fromDate, String toDate) = _GetCallPlan;
  const factory CallPlanEvent.updateCallPlan(CallPlan callPlan) = _UpdateCallPlan;
  const factory CallPlanEvent.deleteCallPlan(CallPlan callPlan) = _DeleteCallPlan;
  const factory CallPlanEvent.addCallPlan(CallPlan callPlan) = _AddCallPlan;
}
