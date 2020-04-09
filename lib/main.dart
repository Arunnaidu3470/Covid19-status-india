import 'package:app/api/covid19.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/home_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Covid19Api api = Covid19Api();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<TimeSeriesModel>(
          create: (cxt) => api.seriesData.allSeriesData(),
        )
      ],
      child: MaterialApp(
        title: 'COVID19 India',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Covid19 India'),
      ),
    );
  }
}
