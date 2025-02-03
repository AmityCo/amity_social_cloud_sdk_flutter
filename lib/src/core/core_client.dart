import 'dart:developer';
import 'dart:io' as io;

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/engine/analytics_engine.dart';
import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_state_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';
import 'package:amity_sdk/src/core/session/session_state_manager.dart';
import 'package:amity_sdk/src/core/session/token/access_token_renewal.dart';
import 'package:amity_sdk/src/core/session/token/token_renewal.dart';
import 'package:amity_sdk/src/core/session/token/token_watcher.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:amity_sdk_api/stream/amity_client_configuration.dart';
import 'package:amity_sdk_api/stream/interfaces/stream_function_interface.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CoreClient {
  static SessionStateManager? _sessionStateManager;
  static SessionLifeCycleEventBus? _sessionLifeCycleEventBus;
  static AppEventBus? _appEventBus;
  static final SessionStateEventBus _sessionStateEventBus = SessionStateEventBus();
  static TokenRenewalSessionComponent? _tokenRenewalSessionComponent = null;
  static TokenWatcherSessionComponent? _tokenWatcherSessionComponent = null;
  static AnalyticsEngine? analyticsEngine = null;
  static int millisTimeDiff = 0;

  ///Do the intial set
  static Future setup({
    required AmityCoreClientOption option,
    bool sycInitialization = false,
  }) async {

    AmityCoreClientOption setupOption = option;

    //Reset config get_it instance
    await configServiceLocator.reset();

    //Reset SDK get_it instance
    await serviceLocator.reset();

    if (io.Platform.isAndroid) {
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        // Switch to compatible endpoint for Android 7.1.1 and below [https://ekoapp.atlassian.net/browse/ASC-24966
        if (androidInfo.version.sdkInt <= 25) {
          final httpEndpoint = option.httpEndpoint;
          switch(httpEndpoint){
            case AmityRegionalHttpEndpoint.SG:
              setupOption = option.copyWith(httpEndpoint: AmityRegionalHttpEndpoint.custom(SG_HTTP_COMPAT_ENDPOINT));
              break;
            case AmityRegionalHttpEndpoint.EU:
              setupOption = option.copyWith(httpEndpoint: AmityRegionalHttpEndpoint.custom(EU_HTTP_COMPAT_ENDPOINT));
              break;
            case AmityRegionalHttpEndpoint.US:
              setupOption = option.copyWith(httpEndpoint: AmityRegionalHttpEndpoint.custom(US_HTTP_COMPAT_ENDPOINT));
              break;
          }
        }
      } catch (e) {
        log("Failed to get platform version: $e");
      }
    }

    configServiceLocator
        .registerLazySingleton<AmityCoreClientOption>(() => setupOption);

    await SdkServiceLocator.initServiceLocator(syc: sycInitialization);

    _intialCleanUp();
    setupSessionComponents();

    final accountRepo = serviceLocator.get<AccountRepo>();
    AccountHiveEntity? account = accountRepo.getAccounts().firstOrNull;
    if (account != null) {
      final userRepo = serviceLocator.get<UserRepo>();
      List<AmityUser> users = userRepo.getUsersFromDB();
      AmityUser? user = users.where((element) => element.userId == account.userId).firstOrNull;
      if (user != null && user.userId != null) {
        if (serviceLocator.isRegistered<AccountHiveEntity>()) {
          serviceLocator.unregister<AccountHiveEntity>();
        }
        serviceLocator.registerSingleton<AccountHiveEntity>(account);
        //Keep the current user in session (service locator)
        if (serviceLocator.isRegistered<AmityUser>()) {
          serviceLocator.unregister<AmityUser>();
        }
        serviceLocator.registerSingleton<AmityUser>(user);
        LoginQueryBuilder.onSessionEstablished(_sessionLifeCycleEventBus!);
        _appEventBus!.publish(AppEvent.AppLaunchWithUser);
      }
    }
    return;
  }

  static void setupSessionComponents() {
    _sessionLifeCycleEventBus ??= SessionLifeCycleEventBus();
    _appEventBus ??= AppEventBus();
    _sessionStateEventBus;
    _sessionStateManager ??= SessionStateManager(
        appEventBus: _appEventBus!,
        sessionStateEventBus: _sessionStateEventBus,
        sessionLifeCycleEventBus: _sessionLifeCycleEventBus!);
    _tokenRenewalSessionComponent ??= TokenRenewalSessionComponent(
        sessionStateEventBus: _sessionStateEventBus,
        sessionLifeCycleEventBus: _sessionLifeCycleEventBus!,
        appEventBus: _appEventBus!);
    _tokenWatcherSessionComponent ??= TokenWatcherSessionComponent(
        sessionStateEventBus: _sessionStateEventBus,
        sessionLifeCycleEventBus: _sessionLifeCycleEventBus!,
        appEventBus: _appEventBus!);
    analyticsEngine = AnalyticsEngine(
      sessionLifeCycleEventBus: _sessionLifeCycleEventBus!,
      sessionStateEventBus: _sessionStateEventBus,
    );
  }

  /// Login with userId, this will create user session
  static LoginQueryBuilder login(String userId, {Function(AccessTokenRenewal)? sessionHandler}) {
    if (sessionHandler != null) {
      _tokenRenewalSessionComponent?.setSessionWillRenewAccessToken(sessionHandler);
    }
    return LoginQueryBuilder(useCase: serviceLocator<LoginUsecase>(), userId: userId, sessionLifeCycleEventBus: _sessionLifeCycleEventBus!, appEventBus: _appEventBus!, isLegacyVersion: sessionHandler == null);
  }

  /// Logout will wipe out all the data [AmityCoreClient] holds.
  static Future<void> logout() async {
    //terminate current activeSocket
    serviceLocator<AmitySocket>().terminate();
    serviceLocator<AmityMQTT>().disconnect();
    _sessionLifeCycleEventBus!.publish(SessionLifeCycle.Destroy);
    _appEventBus!.publish(AppEvent.ManualLogout);
    //close all the hive boxes and wipe the data
    await serviceLocator<DBClient>().reset();

    //Reload the service locator
    await SdkServiceLocator.reloadServiceLocator();

    return;
  }

  ///temporarily disconnect chat real-time events from the system,
  //call the function 'login(String userId)' to restore a connection
  static void disconnect() {
    serviceLocator<AmitySocket>().terminate();
    serviceLocator<AmityMQTT>().disconnect();
  }

  ///Check if user is logged in
  static bool isUserLoggedIn(){
    try {
      getCurrentUser();
      return true;
    } catch (error) {
      return false;
    }
  }

  ///Get logged in user id
  ///if user is not logged in this method will Through [AmityException]
  static String getUserId() {
    return getCurrentUser().userId!;
  }

  ///Get logged in user
  ///if user is not logged in this method will Through [AmityException]
  static AmityUser getCurrentUser() {
    // serviceLocator<AccountDbAdapter>().getAccountEntity(userId)
    if (serviceLocator.isRegistered<AmityUser>()) {
      return serviceLocator<AmityUser>();
    }
    throw AmityException(
      message: 'App dont have active user, Please login',
      code: 401,
    );
  }

  static AmityClientConfiguration getConfiguration() {
    return AmityClientConfiguration(serviceLocator<StreamFunctionInterface>());
  }

  /// API to update the user
  static UserUpdateQueryBuilder updateUser() {
    return UserUpdateQueryBuilder(
        serviceLocator<UpdateUserUsecase>(), getUserId());
  }

  ///Register the devie to receive FCM token
  static Future registerDeviceNotification(String fcmToken) {
    return serviceLocator<NotificationRepository>()
        .registerDeviceNotification(fcmToken);
  }

  ///Unregister the device with FCM
  static Future unregisterDeviceNotification() {
    return serviceLocator<NotificationRepository>()
        .unregisterDeviceNotification();
  }

  static AmityNotification notifications()  {
        return AmityNotification();
    }

  /// Check if Current user have the permissions
  static AmityPermissionValidator hasPermission(AmityPermission permission) {
    return AmityPermissionValidator(permission);
  }

  /// Create new User Repository
  static UserRepository newUserRepository() => serviceLocator<UserRepository>();

  /// Create new File Repository
  static AmityFileRepository newFileRepository() =>
      serviceLocator<AmityFileRepository>();

  /// Intial Clean for SDK
  static _intialCleanUp() {
    // Remove all the Syncing State Message (Unsend messages)
    serviceLocator<MessageDbAdapter>()
        .updateUnsyncedMessagesToFailed();
  }

  static AnalyticsEngine? getAnalyticsEngine() {
    return analyticsEngine;
  }

  static Stream<SessionState> observeSessionState() {
    return _sessionStateEventBus.observe().distinct((prev, current) {
      if (prev.isTerminated() && current.isTerminated()) {
        return (prev as Terminated).error == (current as Terminated).error;
      } else {
        return prev == current;
      }
    });
  }

  static void onAppEvent(AppEvent event) {
    _appEventBus?.publish(event);
  }

  static bool isLegacyLogin() {
    return _tokenRenewalSessionComponent?.isLegacyLogin() ?? true;
  }
  
  static DateTime getServerTime() {
    return DateTime.now().add(Duration(milliseconds: millisTimeDiff));
  }
}
