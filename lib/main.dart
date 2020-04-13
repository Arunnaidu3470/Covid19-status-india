import 'package:app/api/covid19.dart';
import 'package:app/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/home_page_screen.dart';
import 'routes.dart' as routes;
import 'package:app/analytics/analytics.dart';
import 'auth/auth_api.dart';

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
        ChangeNotifierProvider<FirebaseAuthApi>(
            lazy: false, create: (context) => FirebaseAuthApi.initialize()),
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
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
        ),
        home: Consumer<FirebaseAuthApi>(
          builder: (context, value, _) {
            switch (value.status) {
              case Status.Uninitialized:
                return SignInScreen();
              case Status.Unauthenticated:
                return SignInScreen();
              case Status.Authenticating:
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case Status.Authenticated:
                return MyHomePage();
              default:
                return SignInScreen();
            }
          },
          child: Builder(builder: (context) => _gotoRoute(context)),
        ),
      ),
    );
  }

  Widget _gotoRoute(BuildContext context) {
    if (Provider.of<FirebaseAuthApi>(context, listen: false).user == null) {
      print('singinscreen');
      return SignInScreen();
    }
    print(
        Provider.of<FirebaseAuthApi>(context, listen: false).user.displayName);
    return MyHomePage();
  }
}
