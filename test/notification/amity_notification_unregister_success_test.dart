import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockNotificationApiInterface extends Mock
    implements NotificationApiInterface {}

// integration_test_id:dc228744-d8b0-4ad0-becf-583147bc15c4
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String userId = 'victimAndroid';
  String deviceId = const Uuid().v1();
  String token = const Uuid().v1();

  final notificationApiInterface = MockNotificationApiInterface();

  setUpAll(() async {
    registerFallbackValue(UnregisterNotificationRequest(
      userId: userId,
      deviceId: deviceId,
    ));

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<NotificationApiInterface>(
      () => notificationApiInterface,
    );
  });

  test(
      'When the user unregisters push notification, it should return a successful result. ',
      () async {
    when(() => notificationApiInterface.unregisterNotification(
        any<UnregisterNotificationRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_notification_register_success.json')
              .readAsString();
      return true;
    });

    final response = await AmityCoreClient.unregisterDeviceNotification();

    expect(response, isA<bool>());
    expect(response, isTrue);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
