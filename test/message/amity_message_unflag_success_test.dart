import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockMessageApiInterface extends Mock implements MessageApiInterface {}
// integration_test_id:afb432ec-52eb-49d7-8054-c162e3b60535
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String messageId = '650bfbeb6d2464171b0c2b90';

  final mockMessageApiInterface = MockMessageApiInterface();

  setUpAll(() async {
    registerFallbackValue(String);

    await AmityCoreClientMockSetup.setup();

    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<MessageApiInterface>(
      () => mockMessageApiInterface,
    );

  });

  test(
      'When user unflags a message, it should return success response.',
      () async {
    when(() =>
            mockMessageApiInterface.flagMessage(any<String>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_channel_unflag_message_success.json')
              .readAsString();
      return CreateMessageResponse.fromJson(json.decode(response));
    } 
    );

    final amityMessage = await AmityChatClient.newMessageRepository()
        .flag(messageId);

    expect(amityMessage, isA<AmityMessage>());
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
