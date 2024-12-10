import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/datasources/callplan_remote_datasource.dart';
import 'callplan_event.dart';
import 'callplan_state.dart';

class CallPlanBloc extends Bloc<CallPlanEvent, CallPlanState> {
  final CallPlanDataSource callPlanDataSource;

  CallPlanBloc({required this.callPlanDataSource}) : super(CallPlanInitial());

  @override
  Stream<CallPlanState> mapEventToState(CallPlanEvent event) async* {
    if (event is LoadCallPlansEvent) {
      yield CallPlanLoadingState();
      try {
        final callPlans = await callPlanDataSource.loadCallPlans(event.fromDate, event.toDate);
        yield CallPlanLoadedState(callPlans: callPlans);
      } catch (e) {
        yield CallPlanErrorState(errorMessage: e.toString());
      }
    }

    if (event is CreateCallPlanEvent) {
      try {
        final success = await callPlanDataSource.createCallPlan(event.callPlan);
        if (success) {
          yield CallPlanCreatedState();
        }
      } catch (e) {
        yield CallPlanErrorState(errorMessage: e.toString());
      }
    }

    if (event is UpdateCallPlanEvent) {
      try {
        final success = await callPlanDataSource.updateCallPlan(event.callPlan);
        if (success) {
          yield CallPlanUpdatedState();
        }
      } catch (e) {
        yield CallPlanErrorState(errorMessage: e.toString());
      }
    }

    if (event is DeleteCallPlanEvent) {
      try {
        final success = await callPlanDataSource.deleteCallPlan(event.callPlanId);
        if (success) {
          yield CallPlanDeletedState();
        }
      } catch (e) {
        yield CallPlanErrorState(errorMessage: e.toString());
      }
    }
  }
}
