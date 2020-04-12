import 'package:app/screen/stay_home_stay_safe_details_screen.dart';
import 'package:flutter/material.dart';

class StayHomeStaySafeList extends StatelessWidget {
  final List<String> assetPaths;
  final List<String> titles;
  final List<String> pageinfo;

  StayHomeStaySafeList({this.assetPaths, this.titles, this.pageinfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: assetPaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                  StayHomeStaySafeDetailsScreen.ROOTNAME,
                  arguments: [
                    titles[index],
                    pageinfo[index],
                    assetPaths[index],
                  ]);
            },
            child: Container(
              color: Colors.transparent,
              width: 300.0,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        assetPaths[index],
                        fit: BoxFit.cover,
                      ),
                    )),
                    Positioned.fill(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.white10, Colors.black54],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                            ))),
                    Positioned(
                      child: Text(
                        titles[index],
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                      bottom: 20,
                      left: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
