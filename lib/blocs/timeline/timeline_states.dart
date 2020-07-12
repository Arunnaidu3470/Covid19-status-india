import 'package:app/api/covid19.dart';

import '../../widgets/state_handler_widget.dart';

abstract class TimelineState implements StateHandlerWidgetState {
  List<CasesTimeSeries> timeline = [];
}

class TimelineInitialState extends TimelineState {
  @override
  StatehandlerStates state = StatehandlerStates.initialState;
}

class TimelineFetchingState extends TimelineState {
  @override
  StatehandlerStates state = StatehandlerStates.loadingState;
}

class TimelineFetchedState extends TimelineState {
  @override
  final List<CasesTimeSeries> timeline;
  @override
  StatehandlerStates state = StatehandlerStates.loadedState;

  TimelineFetchedState(this.timeline);
}

class TimelineErrorState extends TimelineState {
  @override
  StatehandlerStates state = StatehandlerStates.errorState;
}
