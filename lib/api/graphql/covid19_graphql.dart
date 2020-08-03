import 'package:app/api/graphql/queries/country.dart';
import 'package:graphql/client.dart';

class Covid19Gql {
  static const String HOST = "https://covidstat.info/graphql";
  GraphQLClient _client;

  CountryCount _countryCount;

  CountryCount get countryCount => _countryCount;

  Covid19Gql() {
    _countryCount = CountryCount(this);
    _client = GraphQLClient(link: HttpLink(uri: HOST), cache: InMemoryCache());
  }

  Future<Map> getData(String queryDoc) async {
    try {
      final result = await _client.query(
        QueryOptions(documentNode: gql(queryDoc)),
      );
      if (!result.hasException)
        return (result.data as Map);
      else {
        //TODO:throw exception
        print(result.exception);
        return {};
      }
    } catch (error) {
      // TODO: throw error
      rethrow;
    }
  }
}
