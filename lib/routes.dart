import 'package:app/screen/active_screen.dart';
import 'package:app/screen/confirmed_screen.dart';
import 'package:app/screen/deceased_screen.dart';
import 'package:app/screen/home_page_screen.dart';
import 'package:app/screen/recovered_screen.dart';
import 'package:app/screen/state_details_screen.dart';
import 'package:app/screen/stay_home_stay_safe_details_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case MyHomePage.ROUTENAME:
      return MaterialPageRoute(builder: (cxt) => MyHomePage());
    case StateDetailsScreen.ROUTENAME:
      if (!(settings.arguments is List)) {
        return null;
      }
      List data = settings.arguments;

      return MaterialPageRoute(
          builder: (cxt) => StateDetailsScreen(name: data[0]));
    case StayHomeStaySafeDetailsScreen.ROOTNAME:
      if (!(settings.arguments is List)) {
        return null;
      }
      List data = settings.arguments;

      return MaterialPageRoute(
          builder: (cxt) => StayHomeStaySafeDetailsScreen(
                screenTitle: data[0],
                markdownBodyData: data[1],
                assetPath: data[2],
              ));
    case ActiveScreen.ROUTE_NAME:
      return MaterialPageRoute(builder: (cxt) => ActiveScreen());
    case ConfirmedScreen.ROUTE_NAME:
      return MaterialPageRoute(builder: (cxt) => ConfirmedScreen());
    case RecoveredScreen.ROUTE_NAME:
      return MaterialPageRoute(builder: (cxt) => RecoveredScreen());
    case DeceasedScreen.ROUTE_NAME:
      return MaterialPageRoute(builder: (cxt) => DeceasedScreen());
    default:
      return MaterialPageRoute(builder: (cxt) => MyHomePage());
  }
}
