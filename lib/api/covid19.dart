library covid19_api;

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'collection/series.dart';
part 'models/time_series_model.dart';
part 'collection/state_district.dart';
part 'models/state_district_model.dart';
part 'collection/deaths_recoveries.dart';
part 'models/deaths_recoveries_model.dart';
part 'collection/daily_state_changes.dart';

class Covid19Api {
  final String _scheme = 'https://';
  final String _hostUrl = 'api.covid19india.org';

  SeriesData _seriesData;
  StateDistrictData _stateDistrict;
  DailyStateChanges _dailyStateChanges;

  SeriesData get seriesData => _seriesData;
  StateDistrictData get stateDistrict => _stateDistrict;
  DailyStateChanges get dailyStateChanges => _dailyStateChanges;

  Covid19Api() {
    _seriesData = SeriesData(this);
    _stateDistrict = StateDistrictData(this);
    _dailyStateChanges = DailyStateChanges(this);
  }

  Future<dynamic> _query(String path) async {
    dynamic data = {};
    String url = _scheme + _hostUrl + path;
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
