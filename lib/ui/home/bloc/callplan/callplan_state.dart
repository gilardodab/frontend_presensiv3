// callplan_state.dart
part of 'callplan_bloc.dart';

@freezed
class CallPlanState with _$CallPlanState {
  // Initial state when the BLoC is first created
  const factory CallPlanState.initial() = _Initial;

  // Loading state when the data is being fetched
  const factory CallPlanState.loading() = _Loading;

  // State when the data is successfully loaded
  const factory CallPlanState.loaded(List<CallPlan> callPlans) = _Loaded;

  // State when there is an error in fetching or processing data
  const factory CallPlanState.error(String message) = _Error;

  // State when no data is available
  const factory CallPlanState.empty() = _Empty;

  // Success state after a successful update or deletion of data
  const factory CallPlanState.success(String message) = _Success;
   const factory CallPlanState.added(String message) = _Added;
}
