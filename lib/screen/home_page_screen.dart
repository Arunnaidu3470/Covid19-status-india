import 'package:app/widgets/count_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../api/covid19.dart';
import '../analytics/analytics.dart';
import 'state_details_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = 'Covid19 India'}) : super(key: key);
  static const String ROUTENAME = '/HomePageScreen';
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final Covid19Api api = Covid19Api();
  final AppAnalytics _appAnalytics = AppAnalytics();
  final ScrollController _scrollController = ScrollController();
  String dropdownValue = 'Confirmed';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                height: 300,
                color: Color.fromRGBO(33, 43, 70, 1),
              )),
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 200,
                    stretch: true,
                    flexibleSpace: _flexibleSpaceBar(),
                  ),
                  Consumer<TimeSeriesModel>(builder: (cxt, value, _) {
                    if (value == null)
                      return SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()));
                    return SliverPadding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      sliver: SliverGrid.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 18,
                          children: <Widget>[
                            CountCard(
                              title: 'Confirmed',
                              titleColor: Colors.red,
                              directionIcon: Icons.arrow_upward,
                              mainCount: value.casesStateWise[0].confirmed,
                              subCount: value.casesStateWise[0].deltaConfirmed,
                              spots: List.generate(
                                  33,
                                  (index) => Spot(
                                      x: index.toDouble(),
                                      y: value.casesTimeSeries
                                          .sublist(
                                            value.casesTimeSeries.length - 33,
                                          )[index]
                                          .dailyConfirmed
                                          .toDouble())),
                              colors: [
                                ColorTween(
                                        begin: Colors.red,
                                        end: Colors.redAccent)
                                    .lerp(0.2),
                                ColorTween(
                                        begin: Colors.red,
                                        end: Colors.redAccent)
                                    .lerp(0.2),
                              ],
                            ),
                            CountCard(
                              title: 'Active',
                              titleColor: Colors.blue,
                              mainCount: value.casesStateWise[0].active,
                              disableChart: true,
                            ),
                            CountCard(
                              title: 'Recovered',
                              titleColor: Colors.green,
                              directionIcon: Icons.arrow_upward,
                              mainCount: value.casesStateWise[0].recovered,
                              subCount: value.casesStateWise[0].deltaRecovered,
                              spots: List.generate(33, (index) {
                                return Spot(
                                    x: index.toDouble(),
                                    y: value.casesTimeSeries
                                        .sublist(value.casesTimeSeries.length -
                                            33)[index]
                                        .dailyRecovered
                                        .toDouble());
                              }),
                              colors: [
                                ColorTween(
                                        begin: Colors.green,
                                        end: Colors.greenAccent)
                                    .lerp(0.2),
                                ColorTween(
                                        begin: Colors.green,
                                        end: Colors.greenAccent)
                                    .lerp(0.2),
                              ],
                            ),
                            CountCard(
                              title: 'Deceased',
                              titleColor: Colors.black45,
                              directionIcon: Icons.arrow_upward,
                              mainCount: value.casesStateWise[0].deaths,
                              subCount: value.casesStateWise[0].deltaDeaths,
                              spots: List.generate(33, (index) {
                                return Spot(
                                    x: index.toDouble(),
                                    y: value.casesTimeSeries
                                        .sublist(value.casesTimeSeries.length -
                                            33)[index]
                                        .dailyDeceased
                                        .toDouble());
                              }),
                              colors: [
                                ColorTween(
                                        begin: Colors.black45,
                                        end: Colors.black87)
                                    .lerp(0.2),
                                ColorTween(
                                        begin: Colors.black45,
                                        end: Colors.black54)
                                    .lerp(0.2),
                              ],
                            ),
                          ]),
                    );
                  }),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  StateList(),
                ],
              ),
            ],
          ),
        ));
  }

  FlexibleSpaceBar _flexibleSpaceBar() {
    return FlexibleSpaceBar(
        background: Align(
      alignment: Alignment.centerLeft,
      child: Consumer<TimeSeriesModel>(builder: (cxt, value, _) {
        if (value == null) return Container();
        return Container(
          margin: const EdgeInsets.only(left: 25),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Covid-19 Tracker\n',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
                TextSpan(
                  text: 'India\n',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Last updated ${_updatedAgo(value.casesStateWise[0].lastUpdatedTime)}',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }

  // SliverToBoxAdapter _title(String title) {
  //   return SliverToBoxAdapter(
  //     child: Container(
  //       alignment: Alignment.centerLeft,
  //       margin: const EdgeInsets.only(left: 15, top: 50, bottom: 30),
  //       decoration: BoxDecoration(
  //         border: Border(
  //             left: BorderSide(color: Theme.of(context).accentColor, width: 3)),
  //       ),
  //       child: Text(
  //         ' $title',
  //         style: Theme.of(context).textTheme.headline5,
  //       ),
  //     ),
  //   );
  // }

  // SliverToBoxAdapter _stayHomeStaySafeList() {
  //   return SliverToBoxAdapter(
  //       child: StayHomeStaySafeList(
  //     assetPaths: stayHomeSafeConstants.IMAGE_ASSET_PATHS,
  //     titles: stayHomeSafeConstants.TITLES,
  //     pageinfo: stayHomeSafeConstants.INFO,
  //   ));
  // }

  // Widget _stateWiseAnimatedList() {
  //   return Consumer<TimeSeriesModel>(
  //     builder: (context, snapshot, _) {
  //       if (snapshot == null)
  //         return SliverToBoxAdapter(child: LinearProgressIndicator());
  //       return LiveSliverList(
  //           showItemInterval: Duration(milliseconds: 10),
  //           showItemDuration: Duration(milliseconds: 500),
  //           reAnimateOnVisibility: false,
  //           itemCount: snapshot.casesStateWise.length,
  //           itemBuilder: (cxt, index, animaton) {
  //             if (index == 0) return Container();
  //             String count;
  //             switch (dropdownValue) {
  //               case 'Confirmed':
  //                 count =
  //                     '${snapshot.casesStateWise[index].confirmed.toString()} [+${snapshot.casesStateWise[index].deltaConfirmed.toString()} ]';
  //                 break;
  //               case 'Active':
  //                 count = '${snapshot.casesStateWise[index].active.toString()}';
  //                 break;
  //               case 'Recovered':
  //                 count =
  //                     '${snapshot.casesStateWise[index].recovered.toString()} [+${snapshot.casesStateWise[index].deltaRecovered.toString()} ]';
  //                 break;
  //               case 'Deceased':
  //                 count =
  //                     '${snapshot.casesStateWise[index].deaths.toString()} [+${snapshot.casesStateWise[index].deltaDeaths.toString()} ]';
  //                 break;
  //               default:
  //                 count =
  //                     '${snapshot.casesStateWise[index].confirmed.toString()} [+${snapshot.casesStateWise[index].deltaConfirmed.toString()} ]';
  //             }
  //             return FadeTransition(
  //               opacity: animaton,
  //               child: Card(
  //                 margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
  //                 child: ListTile(
  //                   trailing: Text(count),
  //                   title: Text(snapshot.casesStateWise[index].state),
  //                   enabled: !(snapshot.casesStateWise[index].confirmed == 0),
  //                   subtitle: Row(
  //                     children: <Widget>[
  //                       Icon(
  //                         Icons.info_outline,
  //                         size: 15,
  //                         color: Colors.white30,
  //                       ),
  //                       Text(
  //                         'Tap for More info',
  //                         style: Theme.of(context)
  //                             .primaryTextTheme
  //                             .subtitle2
  //                             .copyWith(fontSize: 10, color: Colors.white30),
  //                       ),
  //                     ],
  //                   ),
  //                   onTap: () {
  //                     //analytics
  //                     _appAnalytics.logStateWiseSelectionEvent(
  //                         snapshot.casesStateWise[index].state);
  //                     Navigator.pushNamed(context, StateDetailsScreen.ROUTENAME,
  //                         arguments: [
  //                           null,
  //                           snapshot.casesStateWise[index].state,
  //                           index
  //                         ]);
  //                   },
  //                 ),
  //               ),
  //             );
  //           },
  //           controller: _scrollController);
  //     },
  //   );
  // }
  String _updatedAgo(String str) {
    if (str == null) return 'recently';
    String day = str.substring(0, 2);
    String month = str.substring(3, 5);
    String year = str.substring(6, 10);
    String time = str.substring(11, 19);
    String formatedDate;
    try {
      formatedDate = timeago.format(DateTime.parse('$year-$month-$day $time'));
    } catch (e) {
      //possible format exception
      return 'recently';
    }
    return formatedDate;
  }
}

class StateTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeSeriesModel>(builder: (cxt, value, _) {
      if (value == null) return Center(child: CircularProgressIndicator());
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          color: Colors.white,
          child: DataTable(
            columnSpacing: 20,
            dividerThickness: 0,
            columns: [
              DataColumn(
                  label: Text('States',
                      style: Theme.of(context).textTheme.bodyText1),
                  tooltip: 'States'),
              DataColumn(
                  label: Text('C',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.red)),
                  tooltip: 'Confirmed'),
              DataColumn(
                  label: Text('A',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.blue)),
                  tooltip: 'Active'),
              DataColumn(
                  label: Text('R',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.green)),
                  tooltip: 'Recovered'),
              DataColumn(
                  label: Text('D',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black45)),
                  tooltip: 'Deceased'),
            ],
            rows: getRows(value),
          ),
        ),
      );
    });
  }

  List<DataRow> getRows(TimeSeriesModel value) {
    List<DataRow> list = [];
    for (CasesStateWise state in value.casesStateWise) {
      list.add(DataRow(cells: [
        DataCell(Text(state.state)),
        DataCell(Text('${state.confirmed}')),
        DataCell(Text('${state.active}')),
        DataCell(Text('${state.recovered}')),
        DataCell(Text('${state.deaths}')),
      ]));
    }

    return list;
  }

  String _trimLength(String str) {
    if (str.length < 8) return str;
    return str.substring(0, 8);
  }
}

class StateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeSeriesModel>(builder: (context, snapshot, _) {
      if (snapshot == null)
        return SliverToBoxAdapter(child: LinearProgressIndicator());
      return SliverPadding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (cxt, index) {
              if (index == 0) return Container();
              return Card(
                child: Container(
                  child: ListTile(
                    trailing:
                        Text('${snapshot.casesStateWise[index].confirmed}'),
                    title: Text(snapshot.casesStateWise[index].state),
                    enabled: !(snapshot.casesStateWise[index].confirmed == 0),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(
                          Icons.info_outline,
                          size: 15,
                          color: Colors.black,
                        ),
                        Text(
                          'Tap for More info',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle2
                              .copyWith(fontSize: 10, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      //analytics
                      // _appAnalytics.logStateWiseSelectionEvent(
                      //     snapshot.casesStateWise[index].state);
                      Navigator.pushNamed(context, StateDetailsScreen.ROUTENAME,
                          arguments: [
                            null,
                            snapshot.casesStateWise[index].state,
                            index
                          ]);
                    },
                  ),
                ),
              );
            },
            childCount: snapshot.casesStateWise.length,
          ),
        ),
      );
    });
  }
}
