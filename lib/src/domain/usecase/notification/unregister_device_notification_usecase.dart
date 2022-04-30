import 'dart:async';

import 'package:amity_sdk/src/core/model/api_request/unregister_notification_request.dart';
import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/repo/notification_repo.dart';
import 'package:amity_sdk/src/domain/repo/repo.dart';

class UnregisterDeviceNotificationUseCase extends UseCase<void, void> {
  final NotificationRepo notificationRepo;
  final AccountRepo accountRepo;

  UnregisterDeviceNotificationUseCase(
      {required this.notificationRepo, required this.accountRepo});

  @override
  Future<void> get(void params) async {
    final AccountHiveEntity account = accountRepo.getAccount();
    if (account.userId == null || account.deviceId == null) {
      throw NullThrownError();
    }
    final UnregisterNotificationRequest request = UnregisterNotificationRequest(
        userId: account.userId!, deviceId: account.deviceId!);
    return notificationRepo.unregisterNotification(request);
  }

  @override
  Stream<void> listen(void params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
