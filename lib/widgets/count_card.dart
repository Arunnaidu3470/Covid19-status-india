import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CountCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final int mainCount;
  final int subCount;
  final IconData directionIcon;
  final bool disableChart;
  final void Function() onTap;
  final List<Spot> spots;
  final List<Color> colors;
  final double height;
  final double width;

  const CountCard({
    this.title,
    this.titleColor,
    this.mainCount,
    this.subCount,
    this.directionIcon,
    this.disableChart = false,
    this.spots,
    this.colors,
    this.onTap,
    this.height = 80,
    this.width = 80,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 25,
        child: Container(
          width: height,
          height: width,
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  title ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black45),
                ),
              ),
              Expanded(
                flex: 2,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: <Widget>[
                    Text(
                      mainCount.toString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: titleColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      directionIcon,
                      color: titleColor,
                      size: 14,
                    ),
                    Text(
                      '${subCount ?? ''}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: titleColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              // SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: (!disableChart)
                    ? CountChart(
                        maxX: _maxX(),
                        maxY: _maxY(),
                        spots: spots,
                        colors: colors,
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  double _maxX() {
    List<double> list = [];
    spots.forEach((element) {
      list.add(element.x);
    });
    list.sort();
    return list[list.length - 1];
  }

  double _maxY() {
    List<double> list = [];
    spots.forEach((element) {
      list.add(element.y);
    });
    list.sort();
    return list[list.length - 1];
  }
}

class CountChart extends StatelessWidget {
  final double maxX;
  final double maxY;
  final List<Spot> spots;
  final List<Color> colors;

  CountChart({this.maxX = 0, this.maxY = 0, this.spots, this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(
        LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData:
                  LineTouchTooltipData(tooltipBgColor: Colors.white),
            ),
            titlesData: FlTitlesData(show: false),
            backgroundColor: Colors.transparent,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            axisTitleData: FlAxisTitleData(show: false),
            minX: 0,
            maxX: maxX + 10,
            minY: 0,
            maxY: maxY,
            lineBarsData: [
              LineChartBarData(
                // showingIndicators: [4],
                aboveBarData: BarAreaData(show: false),
                belowBarData: BarAreaData(show: false),
                spots: spots.map<FlSpot>((e) => FlSpot(e.x, e.y)).toList(),
                isCurved: true,
                barWidth: 3,
                isStrokeCapRound: true,
                colors: colors,
                dotData: FlDotData(
                  dotSize: 4,
                  checkToShowDot: (spot) {
                    return spot.y == spots[spots.length - 1].y;
                  },
                  show: true,
                ),
              )
            ]),
      ),
    );
  }
}

class Spot {
  final double x;
  final double y;
  Spot({this.x, this.y});
}
