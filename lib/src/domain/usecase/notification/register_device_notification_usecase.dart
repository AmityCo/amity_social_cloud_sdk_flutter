import 'dart:async';
import 'dart:io' if (dart.library.html) 'dart:html' show Platform;

import 'package:amity_sdk/src/core/model/api_request/register_notification_request.dart';
import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class RegisterDeviceNotificationUseCase extends UseCase<void, String> {
  final NotificationRepo notificationRepo;
  final AccountRepo accountRepo;

  RegisterDeviceNotificationUseCase(
      {required this.notificationRepo, required this.accountRepo});

  @override
  Future<void> get(String params) async {
    final currentUser = AmityCoreClient.getCurrentUser();
    final account = accountRepo.getAccount(currentUser.userId!);
    if (account?.userId == null || account?.deviceId == null) {
      throw TypeError();
    }
    var platform = "";
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "android";
    } else {
      platform = 'unknown';
    }
    final RegisterNotificationRequest request = RegisterNotificationRequest(
        userId: account!.userId!,
        deviceId: account.deviceId!,
        token: params,
        provider: "fcm",
        platform: platform);
    return notificationRepo.registerNotification(request);
  }
}
