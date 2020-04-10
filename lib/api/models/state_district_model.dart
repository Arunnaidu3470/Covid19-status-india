part of covid19_api;

class StateDistrictModel {
  final String state;
  final List<DistrictDataModel> districtData;
  StateDistrictModel({this.state, this.districtData});

  static List<StateDistrictModel> fromData(List statesData) {
    List<StateDistrictModel> list = [];
    for (int i = 0; i < statesData.length; i++) {
      list.add(StateDistrictModel(
          state: statesData[i]['state'],
          districtData:
              DistrictDataModel.fromData(statesData[i]['districtData'])));
    }
    return list;
  }
}

class DistrictDataModel {
  final String district;
  final int confirmed;
  final String lastUpdateTime;
  final DeltaModel delta;
  DistrictDataModel(
      {this.district, this.confirmed, this.lastUpdateTime, this.delta});

  static List<DistrictDataModel> fromData(List districtData) {
    List<DistrictDataModel> list = [];
    for (int i = 0; i < districtData.length; i++) {
      list.add(DistrictDataModel(
          district: districtData[i]['district'],
          confirmed: districtData[i]['confirmed'],
          lastUpdateTime: districtData[i]['lastupdatedtime'],
          delta: DeltaModel.fromData(districtData[i]['delta'])));
    }
    return list;
  }
}

class DeltaModel {
  final int confirmed;
  DeltaModel({this.confirmed});
  factory DeltaModel.fromData(Map delta) {
    return DeltaModel(confirmed: delta['confirmed']);
  }
}
