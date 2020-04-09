import 'package:app/widgets/home_info_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/covid19.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Covid19Api api = Covid19Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.title),
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<TimeSeriesModel>(builder: (cxt, snapshot, child) {
              if (snapshot == null) return Container();
              return HomeInfoCards(
                context: cxt,
                activeCases: snapshot.casesStateWise[0].active.toString(),
                totalConfirmed: snapshot.casesStateWise[0].confirmed.toString(),
                deltaConfirmed:
                    snapshot.casesStateWise[0].deltaConfirmed.toString(),
                deltaRecovered:
                    snapshot.casesStateWise[0].deltaRecovered.toString(),
                deltaDeaths: snapshot.casesStateWise[0].deltaDeaths.toString(),
              );
            }),
          ),
          Consumer<TimeSeriesModel>(
            builder: (context, snapshot, _) {
              if (snapshot == null)
                return SliverToBoxAdapter(child: LinearProgressIndicator());
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (cxt, index) {
                    if (index == 0) return Container();
                    return ListTile(
                      trailing: Text(
                          snapshot.casesStateWise[index].active.toString()),
                      title:
                          Text(snapshot.casesStateWise[index].state.toString()),
                    );
                  },
                  childCount: snapshot.casesStateWise.length,
                ),
              );
            },
          )
        ],
      ),
    ));
  }
}
