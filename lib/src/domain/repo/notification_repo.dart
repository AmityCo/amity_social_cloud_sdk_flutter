
import 'package:amity_sdk/src/core/model/model.dart';

abstract class NotificationRepo {
  Future registerNotification(RegisterNotificationRequest request);
  Future unregisterNotification(UnregisterNotificationRequest request);
}
