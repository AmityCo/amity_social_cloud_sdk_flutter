import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:9c5d893c-4fc8-4e5d-a5b4-d72e69ac2fba
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

  test('When user unblocks blocked user, it should return success', () async {
    when(() => userApiInterface.unblock(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_user_unblock_success.json').readAsString();
      return FollowInfoResponse.fromJson(json.decode(response));
    });

    final result = await AmityCoreClient.newUserRepository().relationship().unblockUser(userId);

    expect(result, isA<bool>());
    expect(result, true);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
