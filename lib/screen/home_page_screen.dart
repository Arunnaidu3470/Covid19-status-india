import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/dialy_count/total_count_bloc.dart';
import '../blocs/dialy_count/total_count_events.dart';
import '../blocs/dialy_count/total_count_state.dart';
import '../blocs/statewise_data/statewise_count_bloc.dart';
import '../blocs/statewise_data/statewise_count_events.dart';
import '../blocs/statewise_data/statewise_count_states.dart';
import '../widgets/color_card.dart';
import '../widgets/state_card.dart';
import '../widgets/state_handler_widget.dart';
import 'history_count_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = 'Covid19 India'}) : super(key: key);
  static const String ROUTENAME = '/HomePageScreen';
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  String dropdownValue = 'Confirmed';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => loadData());
  }

  void loadData() async {
    BlocProvider.of<TotalCountBloc>(context).add(TotalCountFetchEvent());
    BlocProvider.of<StatewiseCountBloc>(context).add(StatewiseFetchEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(71, 62, 151, 1),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          BlocProvider.of<TotalCountBloc>(context).add(TotalCountFetchEvent());
          BlocProvider.of<StatewiseCountBloc>(context)
              .add(StatewiseFetchEvent());
        },
      ),
      body: Stack(
        children: [
          Header(),
          TweenAnimationBuilder(
            tween: Tween<Offset>(begin: Offset(0, 400), end: Offset(0, 0)),
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            builder: (context, offset, child) {
              return Transform.translate(
                offset: offset,
                child: DraggableScrollableSheet(
                  minChildSize: 0.4,
                  initialChildSize: 0.4,
                  maxChildSize: 1,
                  builder: (_, controller) {
                    return CustomSheet(controller);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: const Color.fromRGBO(71, 62, 151, 1),
          borderRadius: const BorderRadius.only(
            bottomLeft: const Radius.circular(20),
            bottomRight: const Radius.circular(20),
          )),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 500,
      child: Column(
        children: [
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Statistics',
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline4
                    .copyWith(fontSize: 25),
              ),
              OutlineButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(HistoryCountScreen.ROUTE_NAME);
                  },
                  highlightedBorderColor: Colors.white70,
                  highlightElevation: 0,
                  borderSide: BorderSide(
                    color: Colors.white38,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Icon(
                    Icons.history,
                    size: 20,
                    color: Colors.white70,
                  ),
                  label: Text(
                    'Previous',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                  ))
            ],
          ),
          SizedBox(height: 30),
          BlocBuilder<TotalCountBloc, TotalCountState>(
              bloc: BlocProvider.of<TotalCountBloc>(context),
              builder: (_, state) {
                return StateHandlerWidget(
                  currentState: state,
                  initialState: (cxt) {
                    return Container(
                      height: 300,
                      width: 100,
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  },
                  loadingState: (cxt) {
                    return Container(
                      height: 300,
                      width: 100,
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  },
                  loadedState: (cxt) {
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
                                backgroundColor:
                                    const Color.fromRGBO(255, 178, 90, 1),
                                title: 'Affected',
                                count: state.confirmed,
                                subCount: state.dailyConfirmed,
                              ),
                              ColorCard(
                                backgroundColor:
                                    const Color.fromRGBO(255, 89, 89, 1),
                                title: 'Death',
                                count: state.deaths,
                                subCount: state.dailyDeaths,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ColorCard(
                                backgroundColor:
                                    const Color.fromRGBO(76, 217, 123, 1),
                                title: 'Recovered',
                                count: state.recovered,
                                subCount: state.dailyRecovered,
                              ),
                              ColorCard(
                                backgroundColor:
                                    const Color.fromRGBO(75, 181, 255, 1),
                                title: 'Active',
                                count: state.active,
                              ),
                            ],
                          ),
                          Text(
                            formatTime(state.updatedOn),
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        ],
                      ),
                    );
                  },
                  errorState: (cxt) {
                    return Text('Error State');
                  },
                );
              }),
        ],
      ),
    );
  }

  String formatTime(DateTime date) {
    return timeago.format(date);
  }
}

class CustomSheet extends StatelessWidget {
  final ScrollController _controller;

  const CustomSheet(this._controller, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
          )),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: (MediaQuery.of(context).size.width / 2) - 20,
            left: (MediaQuery.of(context).size.width / 2) - 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color.fromRGBO(71, 62, 151, 0.5),
              ),
              width: 100,
              height: 5,
            ),
          ),
          Positioned.fill(
            top: 20,
            child: ListView(
              controller: _controller,
              children: [
                BlocBuilder<StatewiseCountBloc, StatewiseCountState>(
                    bloc: BlocProvider.of<StatewiseCountBloc>(context),
                    builder: (_, state) {
                      return StateHandlerWidget(
                        currentState: state,
                        initialState: (_) => Container(),
                        loadingState: (_) => Container(),
                        loadedState: (_) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Top 8 Affected States',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4
                                          .copyWith(color: Colors.black54),
                                    ),
                                    OutlineButton(
                                      child: Text('See all'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(71, 62, 151, 1)),
                                      highlightedBorderColor:
                                          Color.fromRGBO(71, 62, 151, 1),
                                      highlightElevation: 0,
                                      textColor: Color.fromRGBO(71, 62, 151, 1),
                                      onPressed: () {
                                        // TODO: show a new screen with all states data
                                      },
                                    )
                                  ],
                                ),
                              ),
                              StateCountList(
                                states: state.states
                                    .sublist(1, 9)
                                    .map((e) => StateCountCard(
                                          stateName: e.state,
                                          totalAffected: e.confirmed,
                                          totalRecovered: e.recovered,
                                          totalDeceased: e.deaths,
                                          recoveredCases: state
                                              .count[e.stateCode]['recovered'],
                                          affectedCases: state
                                              .count[e.stateCode]['confirmed'],
                                          deceasedCases: state
                                              .count[e.stateCode]['deceased'],
                                        ))
                                    .toList(),
                              ),
                            ],
                          );
                        },
                        errorState: (_) => Container(),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
