import 'package:app/screen/active_screen.dart';
import 'package:app/screen/confirmed_screen.dart';
import 'package:app/screen/deceased_screen.dart';
import 'package:app/screen/recovered_screen.dart';
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
        body: SafeArea(
          top: false,
          child: Container(
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

                      return SliverLayoutBuilder(
                        builder: (cxt, size) {
                          double leftPadding;
                          double rightPadding;

                          if (size.crossAxisExtent < 650) {
                            leftPadding = 20;
                            rightPadding = 20;
                          } else if (size.crossAxisExtent > 650 &&
                              size.crossAxisExtent < 800) {
                            leftPadding = 50;
                            rightPadding = 150;
                          } else if (size.crossAxisExtent > 800 &&
                              size.crossAxisExtent < 1001) {
                            leftPadding = 50;
                            rightPadding = 350;
                          } else if (size.crossAxisExtent > 1000 &&
                              size.crossAxisExtent < 1500) {
                            leftPadding = 50;
                            rightPadding = 600;
                          } else if (size.crossAxisExtent > 1500 &&
                              size.crossAxisExtent < 1800) {
                            leftPadding = 50;
                            rightPadding = 900;
                          } else {
                            leftPadding = 50;
                            rightPadding = 900;
                          }

                          return _cardGroup(value, leftPadding, rightPadding);
                        },
                      );
                    }),
                    SliverToBoxAdapter(child: SizedBox(height: 20)),
                    // someother details
                  ],
                ),
              ],
            ),
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

  Widget _cardGroup(
      TimeSeriesModel value, double leftPadding, double rightPadding) {
    return SliverPadding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      sliver: SliverGrid.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 18,
          children: <Widget>[
            Hero(
              tag: 'confirmed-card-tag',
              child: CountCard(
                onTap: () =>
                    Navigator.of(context).pushNamed(ConfirmedScreen.ROUTE_NAME),
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
                  ColorTween(begin: Colors.red, end: Colors.redAccent)
                      .lerp(0.2),
                  ColorTween(begin: Colors.red, end: Colors.redAccent)
                      .lerp(0.2),
                ],
              ),
            ),
            Hero(
              tag: 'active-card-tag',
              child: CountCard(
                onTap: () =>
                    Navigator.of(context).pushNamed(ActiveScreen.ROUTE_NAME),
                title: 'Active',
                titleColor: Colors.blue,
                mainCount: value.casesStateWise[0].active,
                disableChart: true,
              ),
            ),
            Hero(
              tag: 'recovered-card-tag',
              child: CountCard(
                title: 'Recovered',
                onTap: () =>
                    Navigator.of(context).pushNamed(RecoveredScreen.ROUTE_NAME),
                titleColor: Colors.green,
                directionIcon: Icons.arrow_upward,
                mainCount: value.casesStateWise[0].recovered,
                subCount: value.casesStateWise[0].deltaRecovered,
                spots: List.generate(33, (index) {
                  return Spot(
                      x: index.toDouble(),
                      y: value.casesTimeSeries
                          .sublist(value.casesTimeSeries.length - 33)[index]
                          .dailyRecovered
                          .toDouble());
                }),
                colors: [
                  ColorTween(begin: Colors.green, end: Colors.greenAccent)
                      .lerp(0.2),
                  ColorTween(begin: Colors.green, end: Colors.greenAccent)
                      .lerp(0.2),
                ],
              ),
            ),
            Hero(
              tag: 'deceased-card-tag',
              child: CountCard(
                title: 'Deceased',
                onTap: () =>
                    Navigator.of(context).pushNamed(DeceasedScreen.ROUTE_NAME),
                titleColor: Colors.black45,
                directionIcon: Icons.arrow_upward,
                mainCount: value.casesStateWise[0].deaths,
                subCount: value.casesStateWise[0].deltaDeaths,
                spots: List.generate(33, (index) {
                  return Spot(
                      x: index.toDouble(),
                      y: value.casesTimeSeries
                          .sublist(value.casesTimeSeries.length - 33)[index]
                          .dailyDeceased
                          .toDouble());
                }),
                colors: [
                  ColorTween(begin: Colors.black45, end: Colors.black87)
                      .lerp(0.2),
                  ColorTween(begin: Colors.black45, end: Colors.black54)
                      .lerp(0.2),
                ],
              ),
            ),
          ]),
    );
  }

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
