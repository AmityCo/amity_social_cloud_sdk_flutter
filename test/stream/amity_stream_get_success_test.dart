import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/data/data_source/remote/api_interface/stream_api_interface.dart';
import 'package:amity_sdk/src/data/response/get_streams_response.dart';
import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockStreamApiInterface extends Mock implements StreamApiInterface {}

// integration_test_id:3046c8a9-6eb5-4234-a8b6-0a31bcebc548
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockStreamApiInterface = MockStreamApiInterface();

  setUpAll(() async {
    registerFallbackValue(String);
    await AmityCoreClientMockSetup.setup();
    serviceLocator.registerLazySingleton<StreamApiInterface>(
      () => mockStreamApiInterface,
    );
  });

  test('When the user query a stream, it should return a valid stream.', () async {
    when(() => mockStreamApiInterface.getStream(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_stream_get_success.json').readAsString();
      return GetStreamsResponse.fromJson(json.decode(response));
    });

    final amityStream = await AmityVideoClient.newStreamRepository().getStream("streamId");

    expect(amityStream, isA<AmityStream>());
  });
}
