part of covid19_api;

class StateDistrictData {
  Covid19Api _api;
  String _path = '/v2/state_district_wise.json';
  StateDistrictData(this._api);

  Future<List<StateDistrictModel>> _parseData() async {
    List data = await _api._query(_path);
    return StateDistrictModel.fromData(data);
  }

  static StateDistrictModel getStateDataByModel(
      StateDistrictModel search, List<StateDistrictModel> stateDisList) {
    for (StateDistrictModel item in stateDisList) {
      if (item.state.toUpperCase() == search.state.toUpperCase()) {
        return item;
      }
    }
    return null;
  }

  static StateDistrictModel getStateDataByName(
      String name, List<StateDistrictModel> stateDisList) {
    for (StateDistrictModel item in stateDisList) {
      if (item.state.toUpperCase() == name.toUpperCase()) {
        return item;
      }
    }
    return null;
  }

  ///Returns a list
  Future<List<StateDistrictModel>> getData() {
    return _parseData();
  }
}
