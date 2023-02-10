import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:a1a8260f-3314-41ba-9f5f-3a96dd52453d
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';
  String displayName = 'Victim Android';
  String updateDisplayName = 'Updated Victim Android';

  final userApiInterface = MockUserApiInterface();

  setUpAll(() async {
    registerFallbackValue(UpdateUserRequest());

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<UserApiInterface>(
      () => userApiInterface,
    );
  });

  test(
      'When the user try to update user, it should return success and updated amity user',
      () async {
    when(() => userApiInterface.updateUser(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_update.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final amityUser = await AmityCoreClient.newUserRepository()
        .updateUser(userId)
        .displayName(updateDisplayName)
        .update();

    expect(amityUser, isA<AmityUser>());
    expect(amityUser.displayName, updateDisplayName);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
