import 'package:app/screen/home_page_screen.dart';
import 'package:app/screen/state_details_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case MyHomePage.ROUTENAME:
      return MaterialPageRoute(builder: (cxt) => MyHomePage());
    case StateDetailsScreen.ROUTENAME:
      print(
          'recived routing to route= ${settings.name}  arguments = ${settings.arguments} condition = ${settings.arguments is List}');
      if (!(settings.arguments is List)) {
        print(
            'error in routing to StateDetailsScreen invalid arguments provided');
        return null;
      }
      List data = settings.arguments;

      return MaterialPageRoute(
          builder: (cxt) => StateDetailsScreen(
                model: data[0],
                name: data[1],
              ));
    default:
      return MaterialPageRoute(builder: (cxt) => MyHomePage());
  }
}
