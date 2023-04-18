import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:d88d68e3-218f-4974-a25f-10695b4d9089
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';

  final userApiInterface = MockUserApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<UserApiInterface>(
      () => userApiInterface,
    );
  });

  test('When user blocks already blocked user, it should return error (400000)', () async {
    when(() => userApiInterface.block(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_user_block_fail.json').readAsString();
      final amityError = AmityErrorResponse.fromJson(json.decode(response));
      throw amityError.amityException();
    });

    try {
      await AmityCoreClient.newUserRepository().relationship().user(userId).block();
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400000);
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
