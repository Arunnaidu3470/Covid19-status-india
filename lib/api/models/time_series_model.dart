part of covid19_api;

class TimeSeriesModel {
  final List<CasesTimeSeries> casesTimeSeries;
  final List<CasesStateWise> casesStateWise;
  final List<CasesTested> casesTested;
  TimeSeriesModel(
      {this.casesTimeSeries, this.casesStateWise, this.casesTested});

  factory TimeSeriesModel.fromData(Map data) {
    return TimeSeriesModel(
      casesTimeSeries: CasesTimeSeries.fromData(data['cases_time_series']),
      casesStateWise: CasesStateWise.fromData(data['statewise']),
      casesTested: CasesTested.fromData(data['tested']),
    );
  }
}

class CasesTimeSeries {
  final int dailyConfirmed;
  final int dailyDeceased;
  final int dailyRecovered;
  final String date;
  final int totalConfirmed;
  final int totalDeceased;
  final int totalRecovered;

  CasesTimeSeries(
      {this.dailyConfirmed,
      this.dailyDeceased,
      this.dailyRecovered,
      this.date,
      this.totalConfirmed,
      this.totalDeceased,
      this.totalRecovered});

  //Generate a List of CasesTimeSeries from given data
  static List<CasesTimeSeries> fromData(List data) {
    List<CasesTimeSeries> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(CasesTimeSeries(
        dailyConfirmed: int.tryParse(data[i]['dailyconfirmed']),
        dailyDeceased: int.tryParse(data[i]['dailydeceased']),
        dailyRecovered: int.tryParse(data[i]['dailyrecovered']),
        date: data[i]['date'],
        totalConfirmed: int.tryParse(data[i]['totalconfirmed']),
        totalDeceased: int.tryParse(data[i]['totaldeceased']),
        totalRecovered: int.tryParse(data[i]['totalrecovered']),
      ));
    }

    return list;
  }

  ///returns Map of current object date
  Map toMap() => {
        'dailyconfirmed': dailyConfirmed,
        'dailydeceased': dailyDeceased,
        'dailyrecovered': dailyRecovered,
        'date': date,
        'totalconfirmed': totalConfirmed,
        'totaldeceased': totalDeceased,
        'totalrecovered': totalRecovered,
      };

  ///returns JSON endoced Map of current object data
  String toJson() => jsonEncode(toMap());
}

class CasesStateWise {
  final int active;
  final int confirmed;
  final int deaths;
  final int deltaConfirmed;
  final int deltaDeaths;
  final int deltaRecovered;
  final String lastUpdatedTime;
  final int recovered;
  final String state;
  final String stateCode;

  CasesStateWise({
    this.active,
    this.confirmed,
    this.deaths,
    this.deltaConfirmed,
    this.deltaDeaths,
    this.deltaRecovered,
    this.lastUpdatedTime,
    this.recovered,
    this.state,
    this.stateCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'confirmed': confirmed,
      'deaths': deaths,
      'deltaconfirmed': deltaConfirmed,
      'deltadeaths': deltaDeaths,
      'deltarecovered': deltaRecovered,
      'lastupdatedtime': lastUpdatedTime,
      'recovered': recovered,
      'state': state,
      'statecode': stateCode,
    };
  }

  static List<CasesStateWise> fromData(List data) {
    List<CasesStateWise> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(CasesStateWise(
        active: int.tryParse(data[i]['active']),
        confirmed: int.tryParse(data[i]['confirmed']),
        deaths: int.tryParse(data[i]['deaths']),
        deltaConfirmed: int.tryParse(data[i]['deltaconfirmed']),
        deltaDeaths: int.tryParse(data[i]['deltadeaths']),
        deltaRecovered: int.tryParse(data[i]['deltarecovered']),
        lastUpdatedTime: data[i]['lastupdatedtime'],
        recovered: int.tryParse(data[i]['recovered']),
        state: data[i]['state'],
        stateCode: data[i]['statecode'],
      ));
    }

    return list;
  }

  String toJson() => json.encode(toMap());
}

class CasesTested {
  final int cyevm;
  final int positiveCasesFromSamplesReported;
  final int sampleReportedToday;
  final String source;
  final int testsConductedByPrivateLabs;
  final int totalIndividualsTested;
  final int totalPositiveCases;
  final int totalSamplesTested;
  final String updateTimestamp;

  CasesTested(
      {this.cyevm,
      this.positiveCasesFromSamplesReported,
      this.sampleReportedToday,
      this.source,
      this.testsConductedByPrivateLabs,
      this.totalIndividualsTested,
      this.totalPositiveCases,
      this.totalSamplesTested,
      this.updateTimestamp});

  Map<String, dynamic> toMap() {
    return {
      'cyevm': cyevm,
      'positivecasesfromsamplesreported': positiveCasesFromSamplesReported,
      'samplereportedtoday': sampleReportedToday,
      'source': source,
      'testsconductedbyprivatelabs': testsConductedByPrivateLabs,
      'totalindividualstested': totalIndividualsTested,
      'totalpositivecases': totalPositiveCases,
      'totalsamplestested': totalSamplesTested,
      'updatetimestamp': updateTimestamp,
    };
  }

  static List<CasesTested> fromData(List data) {
    if (data == null) return null;
    List<CasesTested> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(CasesTested(
        cyevm: int.tryParse(data[i]['_cyevm'] ?? ''),
        positiveCasesFromSamplesReported:
            int.tryParse(data[i]['positivecasesfromsamplesreported'] ?? ''),
        sampleReportedToday: int.tryParse(data[i]['samplereportedtoday'] ?? ''),
        source: data[i]['source'],
        testsConductedByPrivateLabs:
            int.tryParse(data[i]['testsconductedbyprivatelabs'] ?? ''),
        totalIndividualsTested:
            int.tryParse(data[i]['totalindividualstested'] ?? ''),
        totalPositiveCases: int.tryParse(data[i]['totalpositivecases']),
        totalSamplesTested: int.tryParse(data[i]['totalsamplestested']),
        updateTimestamp: data[i]['updatetimestamp'],
      ));
    }
    return list;
  }

  String toJson() => json.encode(toMap());
}
