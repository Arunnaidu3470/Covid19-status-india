import 'package:app/api/covid19.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class ConfirmedCasesChart extends StatefulWidget {
  @override
  _ConfirmedCasesChartState createState() => _ConfirmedCasesChartState();
}

class _ConfirmedCasesChartState extends State<ConfirmedCasesChart> {
  Covid19Api api = Covid19Api();
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        child: Consumer<TimeSeriesModel>(builder: (cxt, snapshot, _) {
          if (snapshot == null)
            return Center(child: CircularProgressIndicator());
          return LineChart(avgData(snapshot.casesTimeSeries));
        }),
      ),
    );
  }

  LineChartData avgData(List<CasesTimeSeries> data) {
    List<FlSpot> spotsConfirmedCasesX = [];

    for (int i = 0; i < data.length; i++) {
      spotsConfirmedCasesX
          .add(FlSpot(i.toDouble(), data[i].totalConfirmed / 1000));
    }
    return LineChartData(
      lineTouchData: LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 10),
          getTitles: (value) {
            if (value % 30 == 0)
              return data[value.toInt()].date.substring(0, 6);
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            int dataY = data[data.length - 1].totalConfirmed ~/ 2000;
            if (value % dataY == 0) return '$value k';
            return ' ';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: data.length.toDouble() + 10,
      minY: 0,
      maxY: data[data.length - 1].totalConfirmed.toDouble() / 500,
      lineBarsData: [
        LineChartBarData(
          spots: spotsConfirmedCasesX, //todo
          // [
          //   FlSpot(0, 10.44),
          //   FlSpot(3, 3.44),
          //   FlSpot(4.9, 3.44),
          //   FlSpot(6.8, 3.44),
          //   FlSpot(8, 3.44),
          //   FlSpot(9.5, 3.44),
          //   FlSpot(11, 3.44),
          //   FlSpot(20, 10.44),
          // ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
