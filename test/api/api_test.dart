import 'package:app/api/covid19.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  Covid19Api _api = Covid19Api();
  group('G - Covid19_api', () {
    test('T - daily state changes', () async {
      print(await _api.dailyStateChanges.getAllStatesCount());
    });
  });
}
