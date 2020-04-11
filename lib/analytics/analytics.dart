import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AppAnalytics {
  static FirebaseAnalytics _analytics;
  static FirebaseAnalyticsObserver _analyticsObserver;

  FirebaseAnalytics get appAnalytics => _analytics;
  FirebaseAnalyticsObserver get appAnalyticsObserver => _analyticsObserver;

  AppAnalytics() {
    _analytics = FirebaseAnalytics();
    _analyticsObserver = FirebaseAnalyticsObserver(analytics: _analytics);
  }

  Future<void> appOpend() async {
    _analytics
        .logAppOpen()
        .then((value) => _logSuccessMessage(_Events.APP_OPENING, ''))
        .catchError((Object obj) =>
            _logErrorMessage(_Events.APP_OPENING, '${obj.toString()}'));
  }

  void logStateWiseSelectionEvent(String stateName) async {
    _analytics
        .logEvent(
            name: _Events.STATE_WISE_COUNT_SELECTION,
            parameters: {'state_name': stateName})
        .then((value) => _logSuccessMessage(
            _Events.STATE_WISE_COUNT_SELECTION, ' data = $stateName'))
        .catchError((Object obj) => _logErrorMessage(
            _Events.STATE_WISE_COUNT_SELECTION,
            ' data = $stateName ${obj.toString()}'));
  }

  void _logSuccessMessage(String eventName, String message) => print(
      '--EVENT-LOG-- --SUCCESS-- Event name = $eventName message = $message');

  void _logErrorMessage(String eventName, String message) => print(
      '--EVENT-LOG-- --Failed-- Event name = $eventName message = $message');
}

class _Events {
  static const String STATE_WISE_COUNT_SELECTION = 'STATE_WISE_COUNT_SELECTION';
  static const String APP_OPENING = 'APP_OPENING';
}
