library covid19_api;

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'collection/series.dart';
part 'models/time_series_model.dart';

class Covid19Api {
  final String _scheme = 'https://';
  final String _hostUrl = 'api.covid19india.org';
  // String _version = '';

  SeriesData _seriesData;

  SeriesData get seriesData => _seriesData;

  Covid19Api() {
    _seriesData = SeriesData(this);
  }

  Future<Map> _query(String path) async {
    Map data = {};
    String url = _scheme + _hostUrl + path;
    print(url);
    http.Response response;
    try {
      response = await http.get(url);
      data = jsonDecode(response.body);
      print(response);
    } catch (e) {
      print(e);
    }
    return data;
  }
}
