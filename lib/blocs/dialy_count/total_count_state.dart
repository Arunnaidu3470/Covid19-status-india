// import 'package:app/api/covid19.dart';

import '../../widgets/state_handler_widget.dart';

abstract class TotalCountState implements StateHandlerWidgetState {
  int confirmed = 0;
  int deaths = 0;
  int recovered = 0;
  int active = 0;
  int dailyConfirmed = 0;
  int dailyDeaths = 0;
  int dailyRecovered = 0;
  int dailyActive = 0;
  DateTime updatedOn = DateTime.now();
  @override
  StatehandlerStates get state => StatehandlerStates.initialState;
}

class TotalCountInitialState extends TotalCountState {
  @override
  StatehandlerStates state = StatehandlerStates.initialState;
}

class TotalCountFetchingState extends TotalCountState {
  @override
  StatehandlerStates state = StatehandlerStates.loadingState;
}

class TotalCountFetchedState extends TotalCountState {
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;
  final int dailyConfirmed;
  final int dailyDeaths;
  final int dailyRecovered;
  final int dailyActive;
  final DateTime dateTime;
  TotalCountFetchedState({
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.dailyConfirmed,
    this.dailyDeaths,
    this.dailyRecovered,
    this.dailyActive,
    this.dateTime,
  });
  @override
  StatehandlerStates state = StatehandlerStates.loadedState;
}

class TotalCountErrorState extends TotalCountState {
  @override
  StatehandlerStates state = StatehandlerStates.errorState;
}
