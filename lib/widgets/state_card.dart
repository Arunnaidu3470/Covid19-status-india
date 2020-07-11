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
  final int count;
  final List<Map<String, String>> confirmedCases;

  const StateCountCard({
    Key key,
    @required this.stateName,
    @required this.count,
    this.confirmedCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 200,
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stateName ?? '',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1
                    .copyWith(color: Colors.red),
              ),
              Text(
                formatNumber(count),
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1
                    .copyWith(color: Colors.red),
              ),
            ],
          ),
          Container(
            height: 100,
            // width: 200,
            child: Chart(
              spots: List.generate(30, (index) {
                return FlSpot(
                  index.toDouble(),
                  double.tryParse(
                      confirmedCases[confirmedCases.length - index - 1]
                          ['count']),
                );
              }),
            ),
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
  final List<FlSpot> spots;

  const Chart({Key key, this.spots}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
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
              minY: maxY(),
              maxY: 6,
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              axisTitleData: FlAxisTitleData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  colors: [
                    const Color(0xff23b6e6),
                    const Color(0xff02d39a),
                  ],
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: false,
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
    return spots.length + 10.0;
  }

  double maxY() {
    List<double> list = spots.map<double>((e) => e.y).toList();
    list.sort();
    return list.last;
  }
}
