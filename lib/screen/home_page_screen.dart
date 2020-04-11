import 'package:auto_animated/auto_animated.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/screen/state_details_screen.dart';
import 'package:app/widgets/home_info_cards.dart';
import 'package:app/widgets/line_chart.dart';
import '../api/covid19.dart';
import '../analytics/analytics.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Container(
                  height: double.maxFinite,
                  width: 600,
                  child: FlareActor(
                    'assets/flare/app_background.flr',
                    animation: 'Background Loop',
                    fit: BoxFit.cover,
                  ),
                )),
                CustomScrollView(
                  // controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      expandedHeight: 100,
                      stretch: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(widget.title),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Consumer<TimeSeriesModel>(
                          builder: (cxt, snapshot, child) {
                        if (snapshot == null) return Container();
                        return Container(
                          child: HomeInfoCards(
                            context: cxt,
                            activeCases:
                                snapshot.casesStateWise[0].active.toString(),
                            totalConfirmed:
                                snapshot.casesStateWise[0].confirmed.toString(),
                            totalRecovered:
                                snapshot.casesStateWise[0].recovered.toString(),
                            deltaConfirmed: snapshot
                                .casesStateWise[0].deltaConfirmed
                                .toString(),
                            deltaRecovered: snapshot
                                .casesStateWise[0].deltaRecovered
                                .toString(),
                            deltaDeaths: snapshot.casesStateWise[0].deltaDeaths
                                .toString(),
                            totalDeaths:
                                snapshot.casesStateWise[0].deaths.toString(),
                            lastUpdatedOn: snapshot
                                .casesStateWise[0].lastUpdatedTime
                                .toString(),
                          ),
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 15, top: 30, bottom: 50),
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 3)),
                        ),
                        child: Text(
                          ' Daily Confirmed Cases(beta)',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ConfirmedCasesChart(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 15, top: 30, bottom: 50, right: 15),
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ' State Wise',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            DropdownButton(
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 10,
                              isDense: true,
                              isExpanded: false,
                              style: TextStyle(color: Colors.white),
                              underline: Container(
                                color: Colors.transparent,
                              ),
                              value: dropdownValue,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: [
                                'Confirmed',
                                'Active',
                                'Recovered',
                                'Deceased'
                              ]
                                  .map((item) => DropdownMenuItem<String>(
                                        child: Text(item),
                                        value: item,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //statewise
                    _stateWiseAnimatedList(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _stateWiseAnimatedList() {
    return Consumer<TimeSeriesModel>(
      builder: (context, snapshot, _) {
        if (snapshot == null)
          return SliverToBoxAdapter(child: LinearProgressIndicator());
        return LiveSliverList(
            showItemInterval: Duration(milliseconds: 5),
            showItemDuration: Duration(milliseconds: 100),
            reAnimateOnVisibility: false,
            itemCount: snapshot.casesStateWise.length,
            itemBuilder: (cxt, index, animaton) {
              if (index == 0) return Container();
              String count;
              switch (dropdownValue) {
                case 'Confirmed':
                  count =
                      '${snapshot.casesStateWise[index].confirmed.toString()} [+${snapshot.casesStateWise[index].deltaConfirmed.toString()} ]';
                  break;
                case 'Active':
                  count = '${snapshot.casesStateWise[index].active.toString()}';
                  break;
                case 'Recovered':
                  count =
                      '${snapshot.casesStateWise[index].recovered.toString()} [+${snapshot.casesStateWise[index].deltaRecovered.toString()} ]';
                  break;
                case 'Deceased':
                  count =
                      '${snapshot.casesStateWise[index].deaths.toString()} [+${snapshot.casesStateWise[index].deltaDeaths.toString()} ]';
                  break;
                default:
                  count =
                      '${snapshot.casesStateWise[index].confirmed.toString()} [+${snapshot.casesStateWise[index].deltaConfirmed.toString()} ]';
              }
              return FadeTransition(
                opacity: animaton,
                child: Card(
                  margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: ListTile(
                    trailing: Text(count),
                    title: Text(snapshot.casesStateWise[index].state),
                    enabled: !(snapshot.casesStateWise[index].confirmed == 0),
                    onTap: () {
                      //analytics
                      _appAnalytics.logStateWiseSelectionEvent(
                          snapshot.casesStateWise[index].state);
                      Navigator.pushNamed(context, StateDetailsScreen.ROUTENAME,
                          arguments: [
                            null,
                            snapshot.casesStateWise[index].state
                          ]);
                    },
                  ),
                ),
              );
            },
            controller: _scrollController);
      },
    );
  }

  Widget _unAnimatedScrollView() {
    return Consumer<TimeSeriesModel>(
      builder: (context, snapshot, _) {
        if (snapshot == null)
          return SliverToBoxAdapter(child: LinearProgressIndicator());
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (cxt, index) {
              if (index == 0) return Container();
              String count;
              switch (dropdownValue) {
                case 'Confirmed':
                  count =
                      '${snapshot.casesStateWise[index].confirmed.toString()} [+${snapshot.casesStateWise[index].deltaConfirmed.toString()} ]';
                  break;
                case 'Active':
                  count = '${snapshot.casesStateWise[index].active.toString()}';
                  break;
                case 'Recovered':
                  count =
                      '${snapshot.casesStateWise[index].recovered.toString()} [+${snapshot.casesStateWise[index].deltaRecovered.toString()} ]';
                  break;
                case 'Deceased':
                  count =
                      '${snapshot.casesStateWise[index].deaths.toString()} [+${snapshot.casesStateWise[index].deltaDeaths.toString()} ]';
                  break;
                default:
                  count =
                      '${snapshot.casesStateWise[index].confirmed.toString()} [+${snapshot.casesStateWise[index].deltaConfirmed.toString()} ]';
              }

              return Card(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: ListTile(
                  trailing: Text(count),
                  title: Text(snapshot.casesStateWise[index].state),
                  enabled: !(snapshot.casesStateWise[index].confirmed == 0),
                  onTap: () {
                    //analytics
                    _appAnalytics.logStateWiseSelectionEvent(
                        snapshot.casesStateWise[index].state);
                    Navigator.pushNamed(context, StateDetailsScreen.ROUTENAME,
                        arguments: [
                          null,
                          snapshot.casesStateWise[index].state
                        ]);
                  },
                ),
              );
            },
            childCount: snapshot.casesStateWise.length,
          ),
        );
      },
    );
  }
}
