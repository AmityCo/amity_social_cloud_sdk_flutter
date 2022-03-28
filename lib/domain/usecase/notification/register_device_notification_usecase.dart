import 'dart:async';

import 'package:amity_sdk/core/model/api_request/register_notification_request.dart';
import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/data/data_source/data_source.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/repo/notification_repo.dart';

class RegisterDeviceNotificationUseCase extends UseCase<void, String> {
  final NotificationRepo notificationRepo;
  final AccountRepo accountRepo;

  RegisterDeviceNotificationUseCase(
      {required this.notificationRepo, required this.accountRepo});

  @override
  Future<void> get(String params) async {
    final AccountHiveEntity account = accountRepo.getAccount();
    if (account.userId == null || account.deviceId == null) {
      throw NullThrownError();
    }
    final RegisterNotificationRequest request = RegisterNotificationRequest(
        userId: account.userId!,
        deviceId: account.deviceId!,
        token: params,
        provider: "fcm",
        platform: "flutter");
    return notificationRepo.registerNotification(request);
  }

  @override
  Stream<void> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
