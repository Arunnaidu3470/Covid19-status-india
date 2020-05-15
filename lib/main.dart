import 'package:app/api/covid19.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/home_page_screen.dart';
import 'routes.dart' as routes;
import 'package:app/analytics/analytics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppAnalytics _analytics = AppAnalytics();
  final Covid19Api api = Covid19Api();
  @override
  Widget build(BuildContext context) {
    _analytics.appOpend();
    return MultiProvider(
      providers: [
        FutureProvider<TimeSeriesModel>(
          lazy: false,
          create: (cxt) => api.seriesData.allSeriesData(),
        ),
        FutureProvider<List<StateDistrictModel>>(
          lazy: false,
          create: (cxt) => api.stateDistrict.getData(),
        ),
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
          primaryColor: Color.fromRGBO(33, 43, 70, 1),
          platform: TargetPlatform.android,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
