import 'package:app/models/src/historic.dart';
import 'package:bloc/bloc.dart';

import '../../api/graphql/covid19_graphql.dart';
import 'country_historical_event.dart';
import 'country_historical_state.dart';

export 'country_historical_event.dart';
export 'country_historical_state.dart';

class CountryHistoricalBloc
    extends Bloc<CountryHistoricalEvent, CountryHistoricalState> {
  final _gql = Covid19Gql();
  CountryHistoricalBloc() : super(CountryHistoricalState.initial());

  @override
  Stream<CountryHistoricalState> mapEventToState(
      CountryHistoricalEvent event) async* {
    if (event is CountryHistoricalFetchEvent) {
      yield* _mapFetchEventToState();
    } else if (event is CountryHistoricalUpdateEvent) {}
  }

  Stream<CountryHistoricalState> _mapFetchEventToState() async* {
    try {
      final historicList = (await _gql.countryCount
          .getHistoricalData())['country']['historical'] as List;
      final finalList =
          historicList.map<Historic>((day) => Historic.fromMap(day)).toList();
      yield CountryHistoricalState.success(finalList);
    } catch (error) {
      print(error);
      yield CountryHistoricalState.failure('Failed to load data from server');
    }
  }
}
