part of covid19_api;

class DeathsRecoveriesDate {
  Covid19Api _api;
  final String _path = '/deaths_recoveries.json';

  DeathsRecoveriesDate(this._api) : assert(_api != null);

  Future<List<DeathsRecoveriesModel>> _parseData() async {
    List respondData = await _api._query(_path);
    return DeathsRecoveriesModel.fromData(respondData);
  }

  Future<List<DeathsRecoveriesModel>> modelData() => _parseData();

  static AgeRatio ageRatio(List<DeathsRecoveriesModel> list) {
    int totalUnknown;
    int totalChildrens;
    int totalTeens;
    int totalAdults;
    int totalElderls;
    for (DeathsRecoveriesModel item in list) {
      if (item.ageBracket == null || item.ageBracket == 0)
        totalUnknown++;
      else if (item.ageBracket < 11 && item.ageBracket > 0)
        totalChildrens++;
      else if (item.ageBracket < 17 && item.ageBracket > 11)
        totalTeens++;
      else if (item.ageBracket > 17 && item.ageBracket < 65)
        totalAdults++;
      else if (item.ageBracket > 65) totalElderls++;
    }
    return AgeRatio(
      totalUnknown: totalUnknown,
      totalChildrens: totalChildrens,
      totalAdults: totalAdults,
      totalTeens: totalTeens,
      totalElderls: totalElderls,
    );
  }
}

class AgeRatio {
  final int totalUnknown;
  final int totalChildrens;
  final int totalTeens;
  final int totalAdults;
  final int totalElderls;
  AgeRatio({
    this.totalUnknown,
    this.totalChildrens,
    this.totalTeens,
    this.totalAdults,
    this.totalElderls,
  });
}
