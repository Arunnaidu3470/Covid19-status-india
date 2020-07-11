import 'package:bloc/bloc.dart';

import '../../api/covid19.dart';
import 'daily_state_changes_events.dart';
import 'daily_state_changes_states.dart';

class DailyStateChangesBloc
    extends Bloc<DailyStateChangesEvent, DailyStateChangesState> {
  DailyStateChangesBloc() : super(DailyStateChangesInitialState());

  Covid19Api _api = Covid19Api();

  @override
  Stream<DailyStateChangesState> mapEventToState(
      DailyStateChangesEvent event) async* {
    yield DailyStateChangesFetchingState();
    if (event is DailyStateChangesFetchEvent) {
      yield DailyStateChangesFetchedState(
          await _api.dailyStateChanges.getAllStatesCount());
    } else {
      yield DailyStateChangesErrorState();
    }
  }
}
