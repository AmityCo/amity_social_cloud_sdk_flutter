import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class NotificationRepository {
  Future registerDeviceNotification(String fcmToken) {
    return serviceLocator<RegisterDeviceNotificationUseCase>().get(fcmToken);
  }

  Future unregisterDeviceNotification() {
    return serviceLocator<UnregisterDeviceNotificationUseCase>().get(null);
  }
}
