import 'package:bloc/bloc.dart';

import '../../api/covid19.dart';
import 'timeline_events.dart';
import 'timeline_states.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc() : super(TimelineInitialState());

  Covid19Api api = Covid19Api();
  @override
  Stream<TimelineState> mapEventToState(TimelineEvent event) async* {
    yield TimelineFetchingState();
    List<CasesTimeSeries> timeline = await api.seriesData.casesTimeSeries();
    yield TimelineFetchedState(timeline);
  }
}
