import 'package:app/api/graphql/covid19_graphql.dart';

class CountryCount {
  Covid19Gql _gql;
  CountryCount(this._gql);

  Future<Map> getTotalCounts() {
    return _gql.getData(r'''
  query {
    country(name: "India") {
      updated
      cases
      active
      deaths
      recovered
      todayCases
      todayDeaths
      tests
    }
  }
  ''');
  }

  Future<Map> getHistoricalData() {
    return _gql.getData(r'''
  query {
    country(name: "India") {
      historical(reverse: true) {
        date
        cases
        deaths
        recovered
        todayCases
        todayRecovered
        todayRecovered
      }
    }
  }

  ''');
  }
}
