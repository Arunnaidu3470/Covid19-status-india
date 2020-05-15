import 'package:app/api/covid19.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateDetailsScreen extends StatefulWidget {
  static const String ROUTENAME = '/StateDetailsScreen';
  final String name;
  StateDetailsScreen({this.name});

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
        top: false,
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
