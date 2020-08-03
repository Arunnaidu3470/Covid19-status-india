import 'package:app/widgets/color_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/timeline/timeline_bloc.dart';
import '../blocs/timeline/timeline_events.dart';
import '../blocs/timeline/timeline_states.dart';

class HistoricalCountScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/HistoryCountScreen';

  @override
  _HistoricalCountScreenState createState() => _HistoricalCountScreenState();
}

class _HistoricalCountScreenState extends State<HistoricalCountScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimelineBloc>(context).add(TimelineFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocBuilder<TimelineBloc, TimelineState>(
                bloc: BlocProvider.of<TimelineBloc>(context),
                builder: (context, state) {
                  if (state.timeline.isNotEmpty) {
                    print(state.timeline[0]?.dailyConfirmed);
                  }
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return Container(
                          width: 100,
                          // height: 100,
                          color: const Color.fromRGBO(71, 62, 151, 1),
                          child: _CountPanel(
                            affected: 0,
                            todayAffected: 0,
                            deaths: 0,
                            todayDeaths: 0,
                            recovered: 0,
                            active: 0,
                            updated: 'DateTime.now()',
                          ));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CountPanel extends StatelessWidget {
  final int affected;
  final int todayAffected;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final String updated;

  const _CountPanel({
    Key key,
    this.affected,
    this.todayAffected,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.updated,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColorCard(
                backgroundColor: const Color.fromRGBO(255, 178, 90, 1),
                title: 'Affected',
                count: affected,
                subCount: todayAffected,
              ),
              ColorCard(
                backgroundColor: const Color.fromRGBO(255, 89, 89, 1),
                title: 'Death',
                count: deaths,
                subCount: todayDeaths,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColorCard(
                backgroundColor: const Color.fromRGBO(76, 217, 123, 1),
                title: 'Recovered',
                count: recovered,
                // subCount: state.to,
              ),
              ColorCard(
                backgroundColor: const Color.fromRGBO(75, 181, 255, 1),
                title: 'Active',
                count: affected - deaths - recovered,
              ),
            ],
          ),
          Text(
            updated,
            style: Theme.of(context).primaryTextTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  String formatTime(DateTime date) {
    if (date == null) return 'Recently';
    return timeago.format(date);
  }
}
