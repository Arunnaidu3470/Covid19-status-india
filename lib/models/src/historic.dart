import 'dart:convert';

class Historic {
  String date;
  int cases;
  int deaths;
  int recovered;
  int todayCases;
  int todayRecovered;
  int todayDeaths;
  Historic({
    this.date,
    this.cases,
    this.deaths,
    this.recovered,
    this.todayCases,
    this.todayRecovered,
    this.todayDeaths,
  });

  Historic copyWith({
    String date,
    int cases,
    int deaths,
    int recovered,
    int todayCases,
    int todayRecovered,
    int todayDeaths,
  }) {
    return Historic(
      date: date ?? this.date,
      cases: cases ?? this.cases,
      deaths: deaths ?? this.deaths,
      recovered: recovered ?? this.recovered,
      todayCases: todayCases ?? this.todayCases,
      todayRecovered: todayRecovered ?? this.todayRecovered,
      todayDeaths: todayDeaths ?? this.todayDeaths,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'cases': cases,
      'deaths': deaths,
      'recovered': recovered,
      'todayCases': todayCases,
      'todayRecovered': todayRecovered,
      'todayDeaths': todayDeaths,
    };
  }

  static Historic fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Historic(
      date: map['date'],
      cases: map['cases'],
      deaths: map['deaths'],
      recovered: map['recovered'],
      todayCases: map['todayCases'],
      todayRecovered: map['todayRecovered'],
      todayDeaths: map['todayDeaths'],
    );
  }

  String toJson() => json.encode(toMap());

  static Historic fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Historic(date: $date, cases: $cases, deaths: $deaths, recovered: $recovered, todayCases: $todayCases, todayRecovered: $todayRecovered, todayDeaths: $todayDeaths)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Historic &&
        o.date == date &&
        o.cases == cases &&
        o.deaths == deaths &&
        o.recovered == recovered &&
        o.todayCases == todayCases &&
        o.todayRecovered == todayRecovered &&
        o.todayDeaths == todayDeaths;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        cases.hashCode ^
        deaths.hashCode ^
        recovered.hashCode ^
        todayCases.hashCode ^
        todayRecovered.hashCode ^
        todayDeaths.hashCode;
  }
}
