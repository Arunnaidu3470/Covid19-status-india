import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'district.dart';
import 'historic.dart';

class State {
  String state;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int active;
  int tests;
  int testsPerOneMillion;
  int updated;
  int recovered;
  int todayRecovered;
  List<District> districts;
  List<Historic> historic;
  State({
    this.state,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.active,
    this.tests,
    this.testsPerOneMillion,
    this.updated,
    this.recovered,
    this.todayRecovered,
    this.districts,
    this.historic,
  });

  State copyWith({
    String state,
    int cases,
    int todayCases,
    int deaths,
    int todayDeaths,
    int active,
    int tests,
    int testsPerOneMillion,
    int updated,
    int recovered,
    int todayRecovered,
    List<District> districts,
    List<Historic> historic,
  }) {
    return State(
      state: state ?? this.state,
      cases: cases ?? this.cases,
      todayCases: todayCases ?? this.todayCases,
      deaths: deaths ?? this.deaths,
      todayDeaths: todayDeaths ?? this.todayDeaths,
      active: active ?? this.active,
      tests: tests ?? this.tests,
      testsPerOneMillion: testsPerOneMillion ?? this.testsPerOneMillion,
      updated: updated ?? this.updated,
      recovered: recovered ?? this.recovered,
      todayRecovered: todayRecovered ?? this.todayRecovered,
      districts: districts ?? this.districts,
      historic: historic ?? this.historic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'cases': cases,
      'todayCases': todayCases,
      'deaths': deaths,
      'todayDeaths': todayDeaths,
      'active': active,
      'tests': tests,
      'testsPerOneMillion': testsPerOneMillion,
      'updated': updated,
      'recovered': recovered,
      'todayRecovered': todayRecovered,
      'districts': districts?.map((x) => x?.toMap())?.toList(),
      'historic': historic?.map((x) => x?.toMap())?.toList(),
    };
  }

  static State fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return State(
      state: map['state'],
      cases: map['cases'],
      todayCases: map['todayCases'],
      deaths: map['deaths'],
      todayDeaths: map['todayDeaths'],
      active: map['active'],
      tests: map['tests'],
      testsPerOneMillion: map['testsPerOneMillion'],
      updated: map['updated'],
      recovered: map['recovered'],
      todayRecovered: map['todayRecovered'],
      districts: List<District>.from(
          map['districts']?.map((x) => District.fromMap(x))),
      historic:
          List<Historic>.from(map['historic']?.map((x) => Historic.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static State fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'State(state: $state, cases: $cases, todayCases: $todayCases, deaths: $deaths, todayDeaths: $todayDeaths, active: $active, tests: $tests, testsPerOneMillion: $testsPerOneMillion, updated: $updated, recovered: $recovered, todayRecovered: $todayRecovered, districts: $districts, historic: $historic)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is State &&
        o.state == state &&
        o.cases == cases &&
        o.todayCases == todayCases &&
        o.deaths == deaths &&
        o.todayDeaths == todayDeaths &&
        o.active == active &&
        o.tests == tests &&
        o.testsPerOneMillion == testsPerOneMillion &&
        o.updated == updated &&
        o.recovered == recovered &&
        o.todayRecovered == todayRecovered &&
        listEquals(o.districts, districts) &&
        listEquals(o.historic, historic);
  }

  @override
  int get hashCode {
    return state.hashCode ^
        cases.hashCode ^
        todayCases.hashCode ^
        deaths.hashCode ^
        todayDeaths.hashCode ^
        active.hashCode ^
        tests.hashCode ^
        testsPerOneMillion.hashCode ^
        updated.hashCode ^
        recovered.hashCode ^
        todayRecovered.hashCode ^
        districts.hashCode ^
        historic.hashCode;
  }
}
