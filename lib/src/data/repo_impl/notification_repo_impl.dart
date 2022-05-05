import 'package:amity_sdk/src/core/model/api_request/register_notification_request.dart';
import 'package:amity_sdk/src/core/model/api_request/unregister_notification_request.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/notification_api_interface.dart';
import 'package:amity_sdk/src/domain/repo/notification_repo.dart';

class NotificationRepoImpl extends NotificationRepo {
  final NotificationApiInterface notificationApiInterface;

  NotificationRepoImpl({required this.notificationApiInterface});

  @override
  Future registerNotification(RegisterNotificationRequest request) {
    return notificationApiInterface.registerNotification(request);
  }

  @override
  Future unregisterNotification(UnregisterNotificationRequest request) {
    return notificationApiInterface.unregisterNotification(request);
  }
}
