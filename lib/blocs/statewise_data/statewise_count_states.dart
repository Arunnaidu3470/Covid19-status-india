import '../../api/covid19.dart';
import '../../widgets/state_handler_widget.dart';

abstract class StatewiseCountState implements StateHandlerWidgetState {
  List<CasesStateWise> states = [];
  Map<String, Map<String, List<Map<String, String>>>> count = {};
}

class StatewiseCountInitialState extends StatewiseCountState {
  @override
  StatehandlerStates state = StatehandlerStates.initialState;
}

class StatewiseCountFetchingState extends StatewiseCountState {
  @override
  StatehandlerStates state = StatehandlerStates.loadingState;
}

class StatewiseCountFetchedState extends StatewiseCountState {
  @override
  final List<CasesStateWise> states;
  final Map<String, Map<String, List<Map<String, String>>>> count;

  @override
  StatehandlerStates state = StatehandlerStates.loadedState;

  StatewiseCountFetchedState(this.states, this.count);
}

class StatewiseCountErrorState extends StatewiseCountState {
  @override
  StatehandlerStates state = StatehandlerStates.errorState;
}
