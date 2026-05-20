import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AnalyticsApi
void main() {
  final instance = ApiClient().getAnalyticsApi();

  group(AnalyticsApi, () {
    // Get user analytics stats
    //
    //Future analyticsControllerGetStats() async
    test('test analyticsControllerGetStats', () async {
      // TODO
    });

    // Track an analytics event (view, start, complete, favorite)
    //
    //Future analyticsControllerTrackEvent(CreateEventDto createEventDto) async
    test('test analyticsControllerTrackEvent', () async {
      // TODO
    });

  });
}
