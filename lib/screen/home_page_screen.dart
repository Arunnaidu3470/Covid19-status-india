import 'package:app/screen/state_details_screen.dart';
import 'package:app/widgets/home_info_cards.dart';
import 'package:app/widgets/line_chart.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/covid19.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = 'Covid19 India'}) : super(key: key);
  static const String ROUTENAME = '/HomePageScreen';
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Covid19Api api = Covid19Api();

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
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
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
                        return HomeInfoCards(
                          context: cxt,
                          activeCases:
                              snapshot.casesStateWise[0].active.toString(),
                          totalConfirmed:
                              snapshot.casesStateWise[0].confirmed.toString(),
                          deltaConfirmed: snapshot
                              .casesStateWise[0].deltaConfirmed
                              .toString(),
                          deltaRecovered: snapshot
                              .casesStateWise[0].deltaRecovered
                              .toString(),
                          deltaDeaths:
                              snapshot.casesStateWise[0].deltaDeaths.toString(),
                          lastUpdatedOn: snapshot
                              .casesStateWise[0].lastUpdatedTime
                              .toString(),
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
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
                            left: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 3)),
                        ),
                        child: Text(
                          ' State Wise Count',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    Consumer<TimeSeriesModel>(
                      builder: (context, snapshot, _) {
                        if (snapshot == null)
                          return SliverToBoxAdapter(
                              child: LinearProgressIndicator());
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (cxt, index) {
                              if (index == 0) return Container();
                              return Card(
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 5),
                                child: ListTile(
                                  trailing: Text(snapshot
                                      .casesStateWise[index].active
                                      .toString()),
                                  title: Text(snapshot
                                      .casesStateWise[index].state
                                      .toString()),
                                  enabled:
                                      !(snapshot.casesStateWise[index].active ==
                                          0),
                                  onTap: () {
                                    print(
                                        'StateRoute with ${snapshot.casesStateWise[index].state}');
                                    Navigator.pushNamed(
                                        context, StateDetailsScreen.ROUTENAME,
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
