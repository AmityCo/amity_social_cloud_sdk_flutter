import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:67cb7ad8-28a9-4950-a86c-35497bb5212c
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'userId';
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

  test('When the user try to update other user, it should return exception',
      () async {
    when(() => userApiInterface.updateUser(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_update_400301.json')
              .readAsString();
      final amityError = AmityErrorResponse.fromJson(json.decode(response));
      throw amityError.amityException();
    });

    try {
      await AmityCoreClient.newUserRepository()
          .updateUser(userId)
          .displayName(updateDisplayName)
          .update();
    } catch (error) {
      expect(error, isA<AmityException>());
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
