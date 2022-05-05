import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class NotificationRepository {
  Future registerDeviceNotification(String fcmToken) {
    return serviceLocator<RegisterDeviceNotificationUseCase>().get(fcmToken);
  }

  Future unregisterDeviceNotification() {
    return serviceLocator<UnregisterDeviceNotificationUseCase>().get(null);
  }
}
