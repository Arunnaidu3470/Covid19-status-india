import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'historic.dart';

class District {
  String district;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int todayRecovered;
  int active;
  List<Historic> historical;
  District({
    this.district,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.historical,
  });

  District copyWith({
    String district,
    int cases,
    int todayCases,
    int deaths,
    int todayDeaths,
    int recovered,
    int todayRecovered,
    int active,
    List<Historic> historical,
  }) {
    return District(
      district: district ?? this.district,
      cases: cases ?? this.cases,
      todayCases: todayCases ?? this.todayCases,
      deaths: deaths ?? this.deaths,
      todayDeaths: todayDeaths ?? this.todayDeaths,
      recovered: recovered ?? this.recovered,
      todayRecovered: todayRecovered ?? this.todayRecovered,
      active: active ?? this.active,
      historical: historical ?? this.historical,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'district': district,
      'cases': cases,
      'todayCases': todayCases,
      'deaths': deaths,
      'todayDeaths': todayDeaths,
      'recovered': recovered,
      'todayRecovered': todayRecovered,
      'active': active,
      'historical': historical?.map((x) => x?.toMap())?.toList(),
    };
  }

  static District fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return District(
      district: map['district'],
      cases: map['cases'],
      todayCases: map['todayCases'],
      deaths: map['deaths'],
      todayDeaths: map['todayDeaths'],
      recovered: map['recovered'],
      todayRecovered: map['todayRecovered'],
      active: map['active'],
      historical: List<Historic>.from(
          map['historical']?.map((x) => Historic.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static District fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'District(district: $district, cases: $cases, todayCases: $todayCases, deaths: $deaths, todayDeaths: $todayDeaths, recovered: $recovered, todayRecovered: $todayRecovered, active: $active, historical: $historical)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is District &&
        o.district == district &&
        o.cases == cases &&
        o.todayCases == todayCases &&
        o.deaths == deaths &&
        o.todayDeaths == todayDeaths &&
        o.recovered == recovered &&
        o.todayRecovered == todayRecovered &&
        o.active == active &&
        listEquals(o.historical, historical);
  }

  @override
  int get hashCode {
    return district.hashCode ^
        cases.hashCode ^
        todayCases.hashCode ^
        deaths.hashCode ^
        todayDeaths.hashCode ^
        recovered.hashCode ^
        todayRecovered.hashCode ^
        active.hashCode ^
        historical.hashCode;
  }
}
