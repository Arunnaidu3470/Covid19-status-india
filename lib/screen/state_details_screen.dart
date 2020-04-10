import 'package:app/api/covid19.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateDetailsScreen extends StatefulWidget {
  static const String ROUTENAME = '/StateDetailsScreen';
  final StateDistrictModel model;
  final String name;
  StateDetailsScreen({this.model, this.name});

  @override
  _StateDetailsScreenState createState() => _StateDetailsScreenState();
}

class _StateDetailsScreenState extends State<StateDetailsScreen> {
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
            Consumer<List<StateDistrictModel>>(builder: (cxt, snapshot, _) {
              if (snapshot == null)
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(),
                );
              StateDistrictModel data =
                  StateDistrictData.getStateDataByName(widget.name, snapshot);
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                (cxt, index) {
                  return ListTile(
                    trailing:
                        Text(data.districtData[index].confirmed.toString()),
                    title: Text(data.districtData[index].district.toString()),
                  );
                },
                childCount: data.districtData.length,
              ));
            })
          ],
        ),
      ),
    );
  }
}
