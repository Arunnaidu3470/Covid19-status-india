import 'package:app/api/covid19.dart';
import 'package:app/screen/state_details_screen.dart';
import 'package:app/widgets/count_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmedScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/confirmed_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmed'),
      ),
      body: SafeArea(
        top: true,
        child: Consumer<TimeSeriesModel>(builder: (cxt, value, _) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: value.casesStateWise.length,
            itemBuilder: (cxt, index) {
              if (index == 0) {
                return Hero(
                  tag: 'confirmed-card-tag',
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                        top: 30, bottom: 30, right: 50, left: 50),
                    child: CountCard(
                      title: 'Total Confirmed',
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
                );
              }
              return ListTile(
                title: Text(
                  value.casesStateWise[index].state,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                trailing: Text(
                  '${value.casesStateWise[index].confirmed.toString()} [+ ${value.casesStateWise[index].deltaConfirmed.toString()}]',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                onTap: () {
                  Navigator.pushNamed(context, StateDetailsScreen.ROUTENAME,
                      arguments: [value.casesStateWise[index].state]);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
