import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeInfoCards extends StatelessWidget {
  final BuildContext context;
  final String activeCases;
  final String totalConfirmed;
  final String deltaConfirmed;
  final String deltaRecovered;
  final String deltaDeaths;
  final String lastUpdatedOn;

  HomeInfoCards(
      {this.context,
      this.activeCases,
      this.totalConfirmed,
      this.deltaConfirmed,
      this.deltaRecovered,
      this.deltaDeaths,
      this.lastUpdatedOn});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Center(
          child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width - 30,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Builder(builder: (_) {
              if (activeCases == null)
                return Center(child: CircularProgressIndicator());
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Today',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white70),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'Confirmed',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(color: Colors.white54),
                          ),
                          Text(
                            '${totalConfirmed ?? '0'}',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline3
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'Total Active',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(color: Colors.white54),
                          ),
                          Text(
                            '${activeCases ?? '0'}',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline3
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '+ ${deltaConfirmed ?? '0'}\nConfirmed',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle2
                            .copyWith(
                              color: Colors.red,
                            ),
                      ),
                      Text('- ${deltaRecovered ?? '0'}\nrecovered',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle2
                              .copyWith(color: Colors.green)),
                      Text('- ${deltaDeaths ?? '0'}\ndeaths',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle2
                              .copyWith(color: Colors.red))
                    ],
                  ),
                  Text(
                    '(updated ${_updatedAgo(lastUpdatedOn)})',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white38,
                        fontStyle: FontStyle.italic,
                        fontSize: 14),
                  ),
                ],
              );
            }),
          ),
        ),
      )),
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
