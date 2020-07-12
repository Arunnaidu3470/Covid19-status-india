import 'package:flutter/material.dart';

class HistoryCountScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/HistoryCountScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              child: Container(
                width: 5,
                height: MediaQuery.of(context).size.height,
                color: Colors.green,
              ),
            ),
            Positioned.fill(child: ListView.builder(
              itemBuilder: (_, index) {
                return Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 13),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 350,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
