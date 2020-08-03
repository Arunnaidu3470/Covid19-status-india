enum TotalCountryCountStates { initial, fetching, success, failure }

class TotalCountryCountState {
  final DateTime updated;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final int deathsPerOneMillion;
  final int tests;
  final int testsPerOneMillion;
  final bool isError;
  final String errorMessage;
  final TotalCountryCountStates state;

  TotalCountryCountState(
    this.state, {
    this.updated,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.isError,
    this.errorMessage,
  });

  // initial
  factory TotalCountryCountState.initial() {
    return TotalCountryCountState(TotalCountryCountStates.initial,
        isError: false);
  }
  // fetching
  factory TotalCountryCountState.fetching() {
    return TotalCountryCountState(TotalCountryCountStates.fetching,
        isError: false);
  }
  // success
  factory TotalCountryCountState.success({
    DateTime updated,
    int cases,
    int todayCases,
    int deaths,
    int todayDeaths,
    int recovered,
    int active,
    int critical,
    int casesPerOneMillion,
    int deathsPerOneMillion,
    int tests,
    int testsPerOneMillion,
    bool isError,
    String errorMessage,
    TotalCountryCountStates state,
  }) {
    return TotalCountryCountState(
      TotalCountryCountStates.success,
      updated: updated,
      cases: cases,
      todayCases: todayCases,
      deaths: deaths,
      todayDeaths: todayDeaths,
      recovered: recovered,
      active: active,
      critical: critical,
      casesPerOneMillion: casesPerOneMillion,
      deathsPerOneMillion: deathsPerOneMillion,
      tests: tests,
      testsPerOneMillion: testsPerOneMillion,
      isError: false,
    );
  }
  // failure
  factory TotalCountryCountState.failure(String errorMessage) {
    return TotalCountryCountState(
      TotalCountryCountStates.failure,
      isError: true,
      errorMessage: errorMessage,
    );
  }
}
