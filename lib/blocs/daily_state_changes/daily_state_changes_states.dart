import 'package:app/widgets/state_handler_widget.dart';

abstract class DailyStateChangesState implements StateHandlerWidgetState {
  Map<String, Map<String, List<Map<String, String>>>> count = {};
}

class DailyStateChangesInitialState extends DailyStateChangesState {
  @override
  StatehandlerStates state = StatehandlerStates.initialState;
}

class DailyStateChangesFetchingState extends DailyStateChangesState {
  @override
  StatehandlerStates state = StatehandlerStates.loadingState;
}

class DailyStateChangesFetchedState extends DailyStateChangesState {
  @override
  final Map<String, Map<String, List<Map<String, String>>>> count;
  @override
  StatehandlerStates state = StatehandlerStates.loadedState;

  DailyStateChangesFetchedState(this.count);
}

class DailyStateChangesErrorState extends DailyStateChangesState {
  @override
  StatehandlerStates state = StatehandlerStates.errorState;
}
