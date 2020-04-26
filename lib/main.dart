import 'package:app/api/covid19.dart';
import 'package:app/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
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
            backgroundColor: Color.fromRGBO(33, 43, 70, 1),
            appBarTheme: AppBarTheme(
                color: Color.fromRGBO(33, 43, 70, 1),
                brightness: Brightness.dark),
            brightness: Brightness.light,
            primaryColor: Color.fromRGBO(33, 43, 70, 1),
            platform: TargetPlatform.android,
          ),
          home: MyHomePage()),
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
