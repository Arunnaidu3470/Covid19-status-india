import 'package:app/api/graphql/covid19_graphql.dart';
import 'package:bloc/bloc.dart';

import 'total_country_count_event.dart';
import 'total_country_count_state.dart';

export 'total_country_count_event.dart';
export 'total_country_count_state.dart';

class TotalCountryCountBloc
    extends Bloc<TotalCountryCountEvent, TotalCountryCountState> {
  final _gql = Covid19Gql();
  TotalCountryCountBloc() : super(TotalCountryCountState.initial());

  @override
  Stream<TotalCountryCountState> mapEventToState(
      TotalCountryCountEvent event) async* {
    if (event is TotalCountryCountFetchEvent) {
      yield* _mapFetchEventToState();
    } else if (event is TotalCountryCountRefreshEvent) {
      yield* _mapRefreshEventToState();
    }
  }

  Stream<TotalCountryCountState> _mapFetchEventToState() async* {
    try {
      yield TotalCountryCountState.fetching();
      final result = await _gql.countryCount.getTotalCounts();
      yield TotalCountryCountState.success(
        updated:
            DateTime.fromMillisecondsSinceEpoch(result['country']['updated']),
        cases: result['country']['cases'] ?? 0,
        todayCases: result['country']['todayCases'] ?? 0,
        deaths: result['country']['deaths'] ?? 0,
        todayDeaths: result['country']['todayDeaths'] ?? 0,
        recovered: result['country']['recovered'] ?? 0,
        active: result['country']['active'] ?? 0,
        critical: result['country']['critical'] ?? 0,
        casesPerOneMillion: result['country']['casesPerOneMillion'] ?? 0,
        deathsPerOneMillion: result['country']['deathsPerOneMillion'] ?? 0,
        tests: result['country']['tests'] ?? 0,
        testsPerOneMillion: result['country']['testsPerOneMillion'] ?? 0,
      );
      print(result);
    } catch (error) {
      print(error);
      yield TotalCountryCountState.failure('Someting went wrong');
    }
  }

  Stream<TotalCountryCountState> _mapRefreshEventToState() async* {
    try {
      final result = await _gql.countryCount.getTotalCounts();
      print(result);
      yield TotalCountryCountState.success(
        updated:
            DateTime.fromMillisecondsSinceEpoch(result['country']['updated']),
        cases: result['country']['cases'] ?? 0,
        todayCases: result['country']['todayCases'] ?? 0,
        deaths: result['country']['deaths'] ?? 0,
        todayDeaths: result['country']['todayDeaths'] ?? 0,
        recovered: result['country']['recovered'] ?? 0,
        active: result['country']['active'] ?? 0,
        critical: result['country']['critical'] ?? 0,
        casesPerOneMillion: result['country']['casesPerOneMillion'] ?? 0,
        deathsPerOneMillion: result['country']['deathsPerOneMillion'] ?? 0,
        tests: result['country']['tests'] ?? 0,
        testsPerOneMillion: result['country']['testsPerOneMillion'] ?? 0,
      );
      print(result);
    } catch (error) {
      print(error);
      // yield TotalCountryCountState.failure('Someting went wrong');
    }
  }
}
