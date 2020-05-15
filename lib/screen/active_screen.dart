import 'package:app/api/covid19.dart';
import 'package:app/screen/state_details_screen.dart';
import 'package:app/widgets/count_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/active_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active'),
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
                  tag: 'active-card-tag',
                  child: Container(
                    height: 140,
                    margin: const EdgeInsets.only(
                        top: 30, bottom: 30, right: 100, left: 100),
                    child: CountCard(
                      title: 'Total Active',
                      titleColor: Colors.blue,
                      mainCount: value.casesStateWise[0].active,
                      disableChart: true,
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
                  value.casesStateWise[index].active.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.blue),
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
