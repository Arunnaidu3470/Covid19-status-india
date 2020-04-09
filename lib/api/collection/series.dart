part of covid19_api;

class SeriesData {
  Covid19Api _api;
  String _path = '/data.json';
  SeriesData(this._api) : assert(_api != null);

  //convert map data to TimeSeriesModel
  Future<TimeSeriesModel> _praseData() async {
    Map respondData = await _api._query(_path);
    return TimeSeriesModel.fromData(respondData);
  }

  ///Provides ALL data from the API
  ///
  ///this returns `TimeSeriesModel` which contails all three models of timeseries data
  ///
  ///- `CasesTimeSeries`: contains time series of data.
  ///
  ///- `CasesStateWise`: contains state wise data.
  ///
  ///- `CasesTested`: contains cases tested data.
  ///
  Future<TimeSeriesModel> allSeriesData() {
    return _praseData();
  }

  ///Only returns `List` of `CasesTimeSeries`
  Future<List<CasesTimeSeries>> casesTimeSeries() async {
    TimeSeriesModel data = await _praseData();
    return data.casesTimeSeries;
  }

  ///Only returns `List` of `CasesStateWise`
  Future<List<CasesStateWise>> casesStateWise() async {
    TimeSeriesModel data = await _praseData();
    return data.casesStateWise;
  }

  ///Only returns `List` of `CasesTested`
  Future<List<CasesTested>> casesTested() async {
    TimeSeriesModel data = await _praseData();
    return data.casesTested;
  }

  Future<Map> allRawData() {
    return _api._query(_path);
  }
}
