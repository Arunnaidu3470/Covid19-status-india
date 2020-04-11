import 'package:app/api/covid19.dart';
import 'package:app/widgets/home_info_cards.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateDetailsScreen extends StatefulWidget {
  static const String ROUTENAME = '/StateDetailsScreen';
  final StateDistrictModel model;
  final String name;
  final int index;
  StateDetailsScreen({this.model, this.name, this.index});

  @override
  _StateDetailsScreenState createState() => _StateDetailsScreenState();
}

class _StateDetailsScreenState extends State<StateDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                title: Text(widget.name),
              ),
            ),
            SliverToBoxAdapter(
              child: Consumer<TimeSeriesModel>(builder: (cxt, snapshot, child) {
                if (snapshot == null) return Container();
                return Container(
                  child: Hero(
                    tag: 'homeinfocard',
                    child: HomeInfoCards(
                      context: cxt,
                      activeCases: snapshot.casesStateWise[widget.index].active
                          .toString(),
                      totalConfirmed: snapshot
                          .casesStateWise[widget.index].confirmed
                          .toString(),
                      totalRecovered: snapshot
                          .casesStateWise[widget.index].recovered
                          .toString(),
                      deltaConfirmed: snapshot
                          .casesStateWise[widget.index].deltaConfirmed
                          .toString(),
                      deltaRecovered: snapshot
                          .casesStateWise[widget.index].deltaRecovered
                          .toString(),
                      deltaDeaths: snapshot
                          .casesStateWise[widget.index].deltaDeaths
                          .toString(),
                      totalDeaths: snapshot.casesStateWise[widget.index].deaths
                          .toString(),
                      lastUpdatedOn: snapshot
                          .casesStateWise[widget.index].lastUpdatedTime
                          .toString(),
                    ),
                  ),
                );
              }),
            ),
            Consumer<List<StateDistrictModel>>(builder: (cxt, snapshot, _) {
              if (snapshot == null)
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(),
                );
              StateDistrictModel data =
                  StateDistrictData.getStateDataByName(widget.name, snapshot);
              return LiveSliverList(
                controller: _scrollController,
                showItemInterval: Duration(milliseconds: 10),
                showItemDuration: Duration(milliseconds: 500),
                reAnimateOnVisibility: false,
                itemCount: data.districtData.length,
                itemBuilder: (cxt, index, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ListTile(
                      trailing:
                          Text(data.districtData[index].confirmed.toString()),
                      title: Text(data.districtData[index].district.toString()),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
