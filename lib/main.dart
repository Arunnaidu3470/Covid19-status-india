import 'package:app/blocs/dialy_count/total_count_bloc.dart';
import 'package:app/blocs/statewise_data/statewise_count_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'analytics/analytics.dart';
import 'api/covid19.dart';
import 'routes.dart' as routes;
import 'screen/home_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppAnalytics _analytics = AppAnalytics();
  final Covid19Api api = Covid19Api();
  @override
  Widget build(BuildContext context) {
    _analytics.appOpend();
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => TotalCountBloc()),
        BlocProvider(lazy: false, create: (context) => StatewiseCountBloc())
      ],
      child: MaterialApp(
        // initialRoute: MyHomePage.ROUTENAME,
        navigatorObservers: <NavigatorObserver>[
          _analytics.appAnalyticsObserver
        ],
        onGenerateRoute: routes.generateRoute,
        title: 'COVID19 India',
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(33, 43, 70, 1),
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(33, 43, 70, 1),
          ),
          primaryTextTheme: TextTheme(
            headline4: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            headline5: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          primaryColor: Color.fromRGBO(33, 43, 70, 1),
          platform: TargetPlatform.android,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
