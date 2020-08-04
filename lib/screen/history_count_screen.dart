import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/historical/country_historical_bloc.dart';
import '../widgets/color_card.dart';
import '../widgets/state_handler_widget.dart';

class HistoricalCountScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/HistoryCountScreen';

  @override
  _HistoricalCountScreenState createState() => _HistoricalCountScreenState();
}

class _HistoricalCountScreenState extends State<HistoricalCountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historic'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocBuilder<CountryHistoricalBloc, CountryHistoricalState>(
                builder: (context, state) {
                  return StateHandlerWidget(
                    currentState: state,
                    initialState: (context) {
                      return Container(
                        width: 100,
                        child: LinearProgressIndicator(),
                      );
                    },
                    loadingState: (context) {
                      return Container(
                        width: 100,
                        child: LinearProgressIndicator(),
                      );
                    },
                    loadedState: (context) {
                      return ListView.builder(
                        itemCount: state.historic.length,
                        itemBuilder: (_, index) {
                          return Container(
                            width: 100,
                            // height: ,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(71, 62, 151, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: _CountPanel(
                              affected: state.historic[index].cases,
                              todayAffected: state.historic[index].todayCases,
                              deaths: state.historic[index].deaths,
                              todayDeaths: state.historic[index].todayDeaths,
                              recovered: state.historic[index].recovered,
                              updated: state.historic[index].date,
                            ),
                          );
                        },
                      );
                    },
                    errorState: (context) {
                      return Container(child: Text(state.failureMessage ?? ''));
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
  final String updated;

  const _CountPanel({
    Key key,
    this.affected,
    this.todayAffected,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.updated,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _formattedDate() ?? '',
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
        Row(
          // scrollDirection: Axis.horizontal,
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
        )
      ],
    );
  }

  String _formattedDate() {
    final date = updated.trim().split('/').map((e) => int.parse(e)).toList();
    if (updated == null) return '';
    return DateFormat.yMMMMd('en_US')
        .format(DateTime(date[2], date[0], date[1]));
    // DateFormat.
  }

  String formatTime(DateTime date) {
    if (date == null) return 'Recently';
    return timeago.format(date);
  }
}
