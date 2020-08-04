import '../../models/models.dart';
import '../../widgets/state_handler_widget.dart';

class CountryHistoricalState extends StateHandlerWidgetState {
  final List<Historic> historic;
  final StatehandlerStates state;
  final bool isFailure;
  final String failureMessage;
  CountryHistoricalState(
    this.state, {
    this.historic,
    this.isFailure,
    this.failureMessage,
  });

  // initial
  factory CountryHistoricalState.initial() {
    return CountryHistoricalState(
      StatehandlerStates.initialState,
      isFailure: false,
      historic: [],
    );
  }
  // fetching
  factory CountryHistoricalState.fetching() {
    return CountryHistoricalState(
      StatehandlerStates.loadingState,
      isFailure: false,
    );
  }
  // success
  factory CountryHistoricalState.success(List<Historic> data) {
    return CountryHistoricalState(
      StatehandlerStates.loadedState,
      historic: data,
      isFailure: false,
    );
  }
  // failure
  factory CountryHistoricalState.failure(String failureMessage) {
    return CountryHistoricalState(
      StatehandlerStates.errorState,
      isFailure: true,
      failureMessage: failureMessage,
    );
  }
}
