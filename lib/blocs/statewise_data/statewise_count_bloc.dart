import 'package:bloc/bloc.dart';

import '../../api/covid19.dart';
import 'statewise_count_events.dart';
import 'statewise_count_states.dart';

class StatewiseCountBloc extends Bloc<StatewiseEvent, StatewiseCountState> {
  StatewiseCountBloc() : super(StatewiseCountInitialState());

  Covid19Api _api = Covid19Api();
  @override
  Stream<StatewiseCountState> mapEventToState(StatewiseEvent event) async* {
    yield StatewiseCountFetchingState();
    if (event is StatewiseFetchEvent) {
      List<CasesStateWise> list = await _api.seriesData.casesStateWise();
      // statecode||  type   || [] of {data:'',count:''}
      Map<String, Map<String, List<Map<String, String>>>> count =
          await _api.dailyStateChanges.getAllStatesCount();
      yield StatewiseCountFetchedState(list, count);
    } else {
      yield StatewiseCountErrorState();
    }
  }
}
