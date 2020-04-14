part of covid19_api;

class DeathsRecoveriesModel {
  final int ageBracket;
  final String city;
  final DateTime data;
  final String deceased;
  final String district;
  final String gender;
  final String nationality;
  final String notes;
  final String patientNumberCouldBeMappedLater;
  final int slno;
  final String source1;
  final String source2;
  final String source3;
  final String state;
  final String stateCode;

  DeathsRecoveriesModel(
      {this.ageBracket,
      this.city,
      this.data,
      this.deceased,
      this.district,
      this.gender,
      this.nationality,
      this.notes,
      this.patientNumberCouldBeMappedLater,
      this.slno,
      this.source1,
      this.source2,
      this.source3,
      this.state,
      this.stateCode});

  static List<DeathsRecoveriesModel> fromData(List data) {
    List<DeathsRecoveriesModel> list = [];
    for (Map item in data) {
      list.add(DeathsRecoveriesModel(
        ageBracket:
            int.parse(item['agebracket'] == "" ? '0' : item['agebracket']),
        city: _checkEmptyString(item['city']),
        data: _parseDateTime(item['date']),
        deceased: _checkEmptyString(item['deceased']),
        district: _checkEmptyString(item['district']),
        gender: _checkEmptyString(item['gender']),
        nationality: _checkEmptyString(item['nationality']),
        notes: _checkEmptyString(item['notes']),
        patientNumberCouldBeMappedLater:
            _checkEmptyString(item['patientnumbercouldbemappedlater']),
        slno: int.parse(item['slno'] ?? '0'),
        source1: _checkEmptyString(item['source1']),
        source2: _checkEmptyString(item['source2']),
        source3: _checkEmptyString(item['source3']),
        state: _checkEmptyString(item['state']),
        stateCode: _checkEmptyString(item['statecode']),
      ));
    }
    return list;
  }

  static DateTime _parseDateTime(String date) {
    if (date == null) return null;
    if (date == "") return null;
    int day = int.parse(date.substring(0, 2));
    print('day $day');
    int month = int.parse(date.substring(3, 5));
    print('month $month');
    int year = int.parse(date.substring(6, 10));
    print('year $year');
    return DateTime(year, month, day);
  }

  static String _checkEmptyString(String str) {
    if (str == "") return null;
    return str;
  }
}
