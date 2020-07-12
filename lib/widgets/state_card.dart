import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StateCountList extends StatelessWidget {
  final List<StateCountCard> states;

  const StateCountList({Key key, this.states}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: TweenAnimationBuilder(
          tween: Tween<Offset>(begin: Offset(-100, 0), end: Offset(0, 0)),
          duration: Duration(milliseconds: 200),
          curve: Curves.bounceInOut,
          builder: (_, offset, child) {
            return Transform.translate(
              offset: offset,
              child: child,
            );
          },
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: states,
          ),
        ));
  }
}

class StateCountCard extends StatelessWidget {
  final String stateName;
  final int totalAffected;
  final int totalRecovered;
  final int totalDeceased;
  final List<Map<String, String>> affectedCases;
  final List<Map<String, String>> recoveredCases;
  final List<Map<String, String>> deceasedCases;

  const StateCountCard({
    Key key,
    @required this.stateName,
    @required this.totalAffected,
    this.affectedCases,
    this.recoveredCases,
    this.totalRecovered,
    this.deceasedCases,
    this.totalDeceased,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
        // color: Color.fromRGBO(71, 62, 151, 0.1),
      ),
      height: 200,
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stateName ?? '',
            style: Theme.of(context)
                .primaryTextTheme
                .headline5
                .copyWith(color: Colors.black87),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Affected',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(color: const Color.fromRGBO(255, 178, 90, 1)),
                  ),
                  Text(
                    formatNumber(totalAffected),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(color: const Color.fromRGBO(255, 178, 90, 1)),
                  ),
                  Text(
                    'Recovered',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(color: const Color.fromRGBO(76, 217, 123, 1)),
                  ),
                  Text(
                    formatNumber(totalRecovered),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(color: const Color.fromRGBO(76, 217, 123, 1)),
                  ),
                  Text(
                    'Deaths',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(color: const Color.fromRGBO(255, 89, 89, 1)),
                  ),
                  Text(
                    formatNumber(totalDeceased),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(color: const Color.fromRGBO(255, 89, 89, 1)),
                  ),
                ],
              ),
              Container(
                height: 100,
                width: 200,
                child: Chart(
                  affectedSpots: List.generate(30, (index) {
                    return FlSpot(
                      index.toDouble(),
                      double.tryParse(
                        affectedCases[(affectedCases.length - 30) + index]
                            ['count'],
                      ),
                    );
                  }),
                  recoveredSpots: List.generate(30, (index) {
                    return FlSpot(
                      index.toDouble(),
                      double.tryParse(
                        recoveredCases[(recoveredCases.length - 30) + index]
                            ['count'],
                      ),
                    );
                  }),
                  deceasedSpots: List.generate(30, (index) {
                    return FlSpot(
                      index.toDouble(),
                      double.tryParse(
                        deceasedCases[(deceasedCases.length - 30) + index]
                            ['count'],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatNumber(int number) {
    if (number == null) return '';
    return NumberFormat('#,##,###').format(number);
  }

  Color getColor(int count) {
    if (count > 200000) {
      return Color.fromRGBO(255, 178, 90, 1);
    } else {
      return Color.fromRGBO(76, 217, 123, 1);
    }
  }
}

class Chart extends StatelessWidget {
  final List<FlSpot> affectedSpots;
  final List<FlSpot> recoveredSpots;
  final List<FlSpot> deceasedSpots;
  const Chart({
    Key key,
    this.affectedSpots,
    this.recoveredSpots,
    this.deceasedSpots,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
            color: Colors.transparent,
          ),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: maxX(),
              minY: 0,
              maxY: maxY(),
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              axisTitleData: FlAxisTitleData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: affectedSpots.reversed.toList(),
                  isCurved: true,
                  colors: [
                    const Color.fromRGBO(255, 178, 90, 0.8),
                    const Color.fromRGBO(255, 178, 90, 1),
                  ],
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    checkToShowDot: (spot) {
                      return spot.x == 29;
                    },
                  ),
                ),
                LineChartBarData(
                  spots: recoveredSpots.reversed.toList(),
                  isCurved: true,
                  colors: [
                    const Color.fromRGBO(76, 217, 123, 0.8),
                    const Color.fromRGBO(76, 217, 123, 1),
                  ],
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    checkToShowDot: (spot) {
                      return spot.x == 29;
                    },
                  ),
                ),
                LineChartBarData(
                  spots: deceasedSpots.reversed.toList(),
                  isCurved: true,
                  colors: [
                    const Color.fromRGBO(255, 89, 89, 0.8),
                    const Color.fromRGBO(255, 89, 89, 1),
                  ],
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    checkToShowDot: (spot) {
                      // print('(${spot.y}, ${spot.x})');
                      return spot.x == 29;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double maxX() {
    return affectedSpots.length + 5.0;
  }

  double maxY() {
    recoveredSpots.reversed.toList().forEach((element) {});
    List<double> list1 = recoveredSpots.map<double>((e) => e.y).toList();
    List<double> list2 = affectedSpots.map<double>((e) => e.y).toList();
    List<double> list3 = deceasedSpots.map<double>((e) => e.y).toList();
    list1.sort();
    list2.sort();
    list3.sort();
    return list1.last > list2.last
        ? list1.last > list3.last ? list1.last : list3.last
        : list2.last > list3.last ? list2.last : list3.last;
  }
}
