import 'package:bloc/bloc.dart';

import '../../api/covid19.dart';
import 'total_count_events.dart';
import 'total_count_state.dart';

class TotalCountBloc extends Bloc<DailyCountEvent, TotalCountState> {
  TotalCountBloc() : super(TotalCountInitialState());
  final Covid19Api api = Covid19Api();

  @override
  Stream<TotalCountState> mapEventToState(DailyCountEvent event) async* {
    yield TotalCountFetchingState();
    if (event is TotalCountFetchEvent) {
      List<CasesStateWise> stateWise = await api.seriesData.casesStateWise();

      yield TotalCountFetchedState(
        confirmed: stateWise.first.confirmed,
        deaths: stateWise.first.deaths,
        recovered: stateWise.first.recovered,
        active: stateWise.first.active,
        dailyConfirmed: stateWise.first.deltaConfirmed,
        dailyDeaths: stateWise.first.deltaDeaths,
        dailyRecovered: stateWise.first.deltaRecovered,
        dailyActive: stateWise.first.active,
        dateTime: formatDate(stateWise.first.lastUpdatedTime),
      );
    } else {
      yield TotalCountErrorState();
    }
  }

  DateTime formatDate(String date) {
    if (date == null) return null;
    String day = date.substring(0, 2);
    String month = date.substring(3, 5);
    String year = date.substring(6, 10);
    String time = date.substring(11, 19);
    return DateTime.parse('$year-$month-$day $time');
  }
}
