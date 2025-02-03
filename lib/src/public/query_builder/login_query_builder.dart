import 'dart:developer';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/mqtt/amity_mqtt.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:uuid/uuid.dart';

/// Login Query Builder
class LoginQueryBuilder {
  late LoginUsecase _useCase;
  late String _userId;
  String? _displayName;
  String? _authToken;
  SessionLifeCycleEventBus? _sessionLifeCycleEventBus;
  AppEventBus? _appEventBus;
  bool isLegacyVersion;

  /// Init Login Query Builder
  LoginQueryBuilder(
      {required useCase,
      required String userId,
      required SessionLifeCycleEventBus sessionLifeCycleEventBus,
      required AppEventBus appEventBus,
      required this.isLegacyVersion}) {
    _useCase = useCase;
    _userId = userId;
    _sessionLifeCycleEventBus = sessionLifeCycleEventBus;
    _appEventBus = appEventBus;
  }

  /// Add Dispplay Name
  LoginQueryBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  /// Add Auth Token
  LoginQueryBuilder authToken(String authToken) {
    _authToken = authToken;
    return this;
  }

  /// Submit the Login Request
  Future<AmityUser> submit() async {
    // Create Authentication Request
    AuthenticationRequest params = AuthenticationRequest(userId: _userId);

    // Check if the user is already logged in
    if (serviceLocator.isRegistered<AccountHiveEntity>()) {

      // Get the active account
      final AccountHiveEntity? activeAccount = serviceLocator<AccountHiveEntity>();
      
      // Get the active user id
      final activeUserId = activeAccount?.userId;

      if (activeUserId != null && activeUserId != _userId) {
        
        // Logout if logging in user is different from the active user
        // To clear all the data related to the active user
        await AmityCoreClient.logout();
        _appEventBus!.publish(AppEvent.LoggingIn);

      } else if (activeUserId == null) {
        
        // Publish "Logging in" event when user is logging in for the first time
        _appEventBus!.publish(AppEvent.LoggingIn);

      } else {
        // If the user is already logged in, use the existing device id
        params.deviceId = activeAccount?.deviceId;

        onSessionEstablished(_sessionLifeCycleEventBus!);
        _appEventBus!.publish(AppEvent.LoginSuccess);
      }

    } else {

      // Publish "Logging in" event when user is logging in for the first time
      _appEventBus!.publish(AppEvent.LoggingIn);

    }

    if (_displayName != null) {
      params.displayName = _displayName;
    }

    if (_authToken != null) {
      params.authToken = _authToken;
    }

    // Generating unique id if existing device id is not available
    if (params.deviceId == null) {
      log('Device id is not exists, generating new device id');
      params.deviceId = const Uuid().v1();
    }

    AmityUser? amityUser;
    try {
      amityUser = await _useCase.get(params);
    } catch (e) {
      _appEventBus!.publish(AppEvent.LoginFail);
      rethrow;
    }
    onSessionEstablished(_sessionLifeCycleEventBus!);
    _appEventBus!.publish(AppEvent.LoginSuccess);

    return amityUser;
  }

  static void onSessionEstablished(
      SessionLifeCycleEventBus sessionLifeCycleEventBus) {
    serviceLocator<AmitySocket>().connect();
    serviceLocator<AmityMQTT>().connect();
    sessionLifeCycleEventBus.publish(SessionLifeCycle.Establish);
  }
}
