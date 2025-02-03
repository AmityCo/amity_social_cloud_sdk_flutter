import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class RenewTokenUseCase
    extends UseCase<void, String?> {
  final AppEventBus appEventBus;
  final SessionLifeCycleEventBus sessionLifeCycleEventBus;
  final AccountHiveEntity account;
  final AuthenticationRepo authRepo;
  final String? authToken;

  RenewTokenUseCase({
    required this.appEventBus,
    required this.sessionLifeCycleEventBus,
    required this.account,
    required this.authRepo,
    this.authToken,
  });

  @override
  Future get(String? authToken) async {
    try {
      final bool isLegacyVersion = CoreClient.isLegacyLogin();

      // Emit logging in event
      appEventBus.publish(AppEvent.LoggingIn);

      // Renew token
      await authRepo.renewToken(
        account: account,
        authToken: authToken,
        isLegacyVersion: isLegacyVersion,
      );

      // Emit success events
      appEventBus.publish(AppEvent.LoginSuccess);
      sessionLifeCycleEventBus.publish(SessionLifeCycle.Establish);
    } catch (error) {
      // Emit failure event
      appEventBus.publish(AppEvent.LoginFail);
      throw error;
    }
  
  }
}
