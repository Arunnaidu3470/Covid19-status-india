library covid19_api;

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'collection/series.dart';
part 'models/time_series_model.dart';
part 'collection/state_district.dart';
part 'models/state_district_model.dart';

class Covid19Api {
  final String _scheme = 'https://';
  final String _hostUrl = 'api.covid19india.org';
  // String _version = '';

  SeriesData _seriesData;
  StateDistrictData _stateDistrict;

  SeriesData get seriesData => _seriesData;
  StateDistrictData get stateDistrict => _stateDistrict;

  Covid19Api() {
    _seriesData = SeriesData(this);
    _stateDistrict = StateDistrictData(this);
  }

  Future<dynamic> _query(String path) async {
    dynamic data = {};
    String url = _scheme + _hostUrl + path;
    print(url);
    http.Response response;
    try {
      response = await http.get(url);
      data = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
    return data;
  }
}
