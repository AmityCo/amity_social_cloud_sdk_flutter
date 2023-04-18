import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:2eaac2bf-cfc5-43a6-b3cb-7b1f90747429
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

  test('When user blocks other user, it should return success', () async {
    when(() => userApiInterface.block(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_user_block_success.json').readAsString();
      return FollowInfoResponse.fromJson(json.decode(response));
    });

    final result = await AmityCoreClient.newUserRepository().relationship().user(userId).block();

    expect(result, isA<bool>());
    expect(result, true);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
