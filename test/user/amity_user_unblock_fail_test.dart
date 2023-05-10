import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:6fd89592-1a5c-48b0-b419-ee8f51395334
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

  test('When user unblocks already unblocked user, it should return error (400000)', () async {
    when(() => userApiInterface.unblock(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_user_unblock_fail.json').readAsString();
      final amityError = AmityErrorResponse.fromJson(json.decode(response));
      throw amityError.amityException();
    });

    try {
      await AmityCoreClient.newUserRepository().relationship().unblockUser(userId);
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400000);
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
