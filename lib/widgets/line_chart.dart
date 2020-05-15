import 'package:app/api/covid19.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class ConfirmedCasesChart extends StatefulWidget {
  @override
  _ConfirmedCasesChartState createState() => _ConfirmedCasesChartState();
}

class _ConfirmedCasesChartState extends State<ConfirmedCasesChart> {
  int selectedValue = 0;

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
      height: 350,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: Consumer<TimeSeriesModel>(builder: (cxt, snapshot, _) {
                if (snapshot == null)
                  return Center(child: CircularProgressIndicator());
                return LineChart(avgData(snapshot.casesTimeSeries));
              }),
            ),
          ),
          Positioned(
              bottom: 5,
              child: Container(
                width: 300,
                height: 50,
                child: CupertinoSegmentedControl<int>(
                    unselectedColor: Colors.transparent,
                    selectedColor: Colors.white12,
                    borderColor: Colors.blue,
                    padding: const EdgeInsets.all(8),
                    groupValue: selectedValue,
                    children: {
                      0: Text('All', style: TextStyle(color: Colors.white70)),
                      1: Text('30-days',
                          style: TextStyle(color: Colors.white70)),
                      2: Text('7-days', style: TextStyle(color: Colors.white70))
                    },
                    pressedColor: Colors.teal.withOpacity(0.5),
                    onValueChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    }),
              ))
        ],
      ),
    );
  }

  LineChartData avgData(List<CasesTimeSeries> data) {
    return LineChartData(
      lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(tooltipBgColor: Colors.black)),
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
          getTitles: (value) => _titlesBottom(value, data),
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) => _titlesLeft(value, data),
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: _maxXAxisValue(data),
      minY: 0,
      maxY: _maxYAxisValue(data),
      lineBarsData: [
        //Confirmed
        LineChartBarData(
          spots: _spotsConfirmedCasesx(data), //todo
          isCurved: true,
          colors: [
            ColorTween(begin: Colors.red, end: Colors.redAccent).lerp(0.2),
            ColorTween(begin: Colors.red, end: Colors.redAccent).lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: Colors.red, end: Colors.redAccent)
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: Colors.red, end: Colors.redAccent)
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
        //Recovered
        LineChartBarData(
          spots: _spotsRecoveryCasesx(data),
          isCurved: true,
          colors: [
            ColorTween(begin: Colors.green, end: Colors.greenAccent).lerp(0.2),
            ColorTween(begin: Colors.green, end: Colors.greenAccent).lerp(0.2),
          ],
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: Colors.green, end: Colors.greenAccent)
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: Colors.red, end: Colors.redAccent)
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
        //Recovered
        LineChartBarData(
          spots:
              // spotsConfirmedCasesX, //todo
              _spotsDeceasedCasesx(data),
          isCurved: true,
          colors: [
            ColorTween(begin: Colors.white, end: Colors.white).lerp(0.2),
            ColorTween(begin: Colors.white, end: Colors.white).lerp(0.2),
          ],
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: Colors.white, end: Colors.white)
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: Colors.white, end: Colors.white)
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }

  List<FlSpot> _spotsRecoveryCasesx(List<CasesTimeSeries> data) {
    List<FlSpot> list = [];
    if (selectedValue == 1) {
      data = data.sublist(data.length - 31);
    } else if (selectedValue == 2) {
      data = data.sublist(data.length - 7);
    }
    for (int i = 0; i < data.length; i++) {
      list.add(FlSpot(i.toDouble(), data[i].totalRecovered / 1000));
    }
    return list;
  }

  List<FlSpot> _spotsDeceasedCasesx(List<CasesTimeSeries> data) {
    List<FlSpot> list = [];
    if (selectedValue == 1) {
      data = data.sublist(data.length - 31);
    } else if (selectedValue == 2) {
      data = data.sublist(data.length - 7);
    }
    for (int i = 0; i < data.length; i++) {
      list.add(FlSpot(i.toDouble(), data[i].totalDeceased / 1000));
    }
    return list;
  }

  List<FlSpot> _spotsConfirmedCasesx(List<CasesTimeSeries> data) {
    List<FlSpot> list = [];

    if (selectedValue == 1) {
      data = data.sublist(data.length - 31);
    } else if (selectedValue == 2) {
      data = data.sublist(data.length - 7);
    }
    for (int i = 0; i < data.length; i++) {
      list.add(FlSpot(i.toDouble(), data[i].totalConfirmed / 1000));
    }

    return list;
  }

  double _maxXAxisValue(List<CasesTimeSeries> data) {
    if (selectedValue == 2) return 7;
    return _spotsConfirmedCasesx(data).length.toDouble() + 10;
  }

  double _maxYAxisValue(List<CasesTimeSeries> data) {
    // if (selectedValue == 1)
    //   return data[data.length - 1].dailyConfirmed.toDouble() / 100;
    if (selectedValue == 2)
      return data[data.length - 1].dailyConfirmed.toDouble() / 80;
    return data[data.length - 1].totalConfirmed.toDouble() / 600;
  }

  String _titlesLeft(double value, List<CasesTimeSeries> data) {
    int dataY = data[data.length - 1].totalConfirmed ~/ 2000;
    if (value % dataY == 0) return '$value k';
    return ' ';
  }

  String _titlesBottom(double value, List<CasesTimeSeries> data) {
    if (selectedValue == 2) {
      if (value < 7) {
        return data
            .sublist(data.length - 7)[value.toInt()]
            .date
            .substring(0, 6);
      }
    }
    if (selectedValue == 1) {
      if (value < 31 && value % 5 == 0) {
        return data
            .sublist(data.length - 31)[value.toInt()]
            .date
            .substring(0, 6);
      }
    }

    if (value % 30 == 0) return data[value.toInt()].date.substring(0, 6);
    return '';
  }
}
