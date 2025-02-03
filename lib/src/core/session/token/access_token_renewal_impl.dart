export 'access_token_renewal.dart';
import 'dart:ui';

import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/token/access_token_renewal.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/token/renew_token_usecase.dart';

class AccessTokenRenewalImpl implements AccessTokenRenewal {
  final AuthenticationRepo authRepo;
  final AccountRepo accountRepo;
  final AppEventBus appEventBus;
  final SessionLifeCycleEventBus sessionLifeCycleEventBus;
  final VoidCallback onRenewTokenSuccess;
  final Function(dynamic throwable) onRenewTokenFailed;
  final VoidCallback onUnableToRetrieveAuthToken;

  bool invalidated = false;

  AccessTokenRenewalImpl({
    required this.authRepo,
    required this.accountRepo,
    required this.appEventBus,
    required this.sessionLifeCycleEventBus,
    required this.onRenewTokenSuccess,
    required this.onRenewTokenFailed,
    required this.onUnableToRetrieveAuthToken,
  });

  @override
  void renew() {
    if (invalidated) return;
    invalidate();
    _refreshToken();
  }

  @override
  void renewWithAuthToken(String authToken) {
    if (invalidated) return;
    invalidate();
    _refreshToken(authToken: authToken);
  }

  @override
  void unableToRetrieveAuthToken() {
    onUnableToRetrieveAuthToken();
  }

  void invalidate() {
    invalidated = true;
  }

  Future<void> _refreshToken({String? authToken}) async {
    try {
      final AccountHiveEntity? account = accountRepo.getAccounts().firstOrNull;
      if (account != null) {
        await RenewTokenUseCase(
          authRepo: authRepo,
          appEventBus: appEventBus,
          sessionLifeCycleEventBus: sessionLifeCycleEventBus,
          account: account,
        ).get(authToken);
        onRenewTokenSuccess();
      }
    } catch (error) {
      onRenewTokenFailed(error);
    }
  }
}