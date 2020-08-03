import 'package:flutter/material.dart';

import 'screen/history_count_screen.dart';
import 'screen/home_page_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MyHomePage.ROUTENAME:
      return MaterialPageRoute(builder: (cxt) => MyHomePage());
    case HistoricalCountScreen.ROUTE_NAME:
      return PageRouteBuilder(
        pageBuilder: (_, animation, secondaryAnimation) {
          return HistoricalCountScreen();
        },
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation.drive<double>(Tween<double>(begin: 0, end: 1)),
            child: child,
          );
        },
      );
    // return MaterialPageRoute(builder: (cxt) => HistoryCountScreen());
    default:
      return MaterialPageRoute(builder: (cxt) => MyHomePage());
  }
}
